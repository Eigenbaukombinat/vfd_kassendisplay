# -*- coding: utf-8 -*-

import socket
from repl_dict import *

class fancystr(str):
	pass

class EbkVfd(object):
	import repl_dict
	s = None
	cursor = 0
	ip = ""
	port = 23
	def __init__(self,ip,port=23):
		try:
			self.s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
			self.s.connect((ip,port))
			self.s.sendall(b"\x10\x14\n\n")
			self.ip = ip
			self.port = port
		except:
			raise Exception("Error creating a socket instance bound to " + ip + ":23")
	
	def __convert_str_char_by_char(self,ch):
		d = repl_dict[u"charset"]
		#print(repr(d))
		if ch in d.keys():
			ch = chr(d[ch])
		else:
			if not ord(ch) in range(126):
				raise Exception("Unsupported char `%s`"%ch)
		return bytes(ch.encode("latin1"))
	
	def __convert_str(self,s):
		if type(s)==fancystr:
			return s
		s = list(s)
		s = map(lambda x:self.__convert_str_char_by_char(x), s)
		return b"".join(s).replace(b"\n",b"\n\x10\x14")
	
	def clear(self):
		self.s.sendall(chr(0x10)+chr(0x14)+"\n\n")
		self.cursor = 0
	
	def setCursorChar(self,c):
		if c>39 or c<0:
			raise Exception("Cursor destination `"+str(c)+"` out of bounds")
		else:
			self.s.sendall(chr(0x10)+chr(c))
	
	def setCursorCoords(self,row,col):
		c = (y*20+x)
		if col<0 or row<0 or row>1 or col>19:
			raise Exception("Cursor destination `"+str(c)+"` out of bounds")
		else:
			setCursorChar(c)
	
	def send(self,s):
		conv = self.__convert_str(s)
		self.s.sendall(bytes(conv))
		#print(repr(conv))
		self.cursor += len(s)
		self.cursor %= 40
	
	def setChar(self,c):
		self.s.sendall(__convert_str(c[0]))
		setCursorChar(self.cursor)
	
	def __repr__(self):
		return "<EBKVFD ip=%s cursor=%s>"%(self.ip,self.cursor)
