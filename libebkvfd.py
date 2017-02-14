import socket

class fancystr(str):
	pass

class EbkVfd(object):
	s = None
	cursor = 0
	ip = ""
	def __init__(self,ip):
		try:
			self.s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
			self.s.bind((ip,23))
			self.s.sendall(chr(0x10)+chr(0x14)+"\n\n")
			self.ip = ip
		except:
			raise Exception("Error creating a socket instance bound to " + ip + ":23")
	def __convert_str(self):
		pass
	def clear(self):
		self.s.sendall(chr(0x10)+chr(0x14)+"\n\n")
		self.cursor = 0
	def setCursorChar(c):
		if c>39 or c<0:
			raise Exception("Cursor destination `"+str(c)+"` out of bounds")
		else:
			self.s.sendall(chr(0x10)+chr(c))
	def setCursorCoords(row,col):
		c = (y*20+x)
		if col<0 or row<0 or row>1 or col>19:
			raise Exception("Cursor destination `"+str(c)+"` out of bounds")
		else:
			setCursorChar(c)
	def print(s):
		self.s.sendall(__convert_str(s))
		self.cursor += len(s)
		self.cursor %= 40
	def __repr__(self):
		return "<ebkvfd ip=\""+ip+"\">"