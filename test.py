import telnetlib
import time
import os

telnet = telnetlib.Telnet('192.168.21.149')

telnet.write('\n'.encode('latin1'))
telnet.write('\n'.encode('latin1'))
telnet.write(chr(0x10).encode('latin1'))
telnet.write(chr(0).encode('latin1'))
telnet.write('Hallöle'.encode('latin1'))

	#os.system('ffmpeg -f video4linux2 -i /dev/v4l/by-id/usb-Winmax_Corp._USB_Microscope-video-index0 -vframes 2 %i.jpg' % x)
