require 'socket'
require 'yaml'
class EbkVfd

	class UnsupportedCharError<StandardError;end

	private

	def convertStr(s)
		dict = YAML.load File.read("dict.yaml")
		s = s.split("")
		s.map! do |ch|
			unless (0..125).to_a.include?(ch.ord)
				if dict.keys.include?(ch)
					ch = dict[ch].chr
				else
					raise(UnsupportedCharError,"Unsupported char `#{ch}`")
				end
			end
			ch
		end
		return s.join.gsub("\n","\n\x10\x14")
	end

	public

	def initialize(ip)
		@socket = TCPSocket.new(ip,23)
		@cursor = 0
		clear
	end

	def clear
		@socket.print("\x10\x14\n\n") #0x10=command(set cursor pos); 0x14=cursor pos
		@cursor = 0
		#sleep 0.05
	end

	def setCursorChar(c)
		@socket.print("\x10"+c.chr)
		@cursor = c
		#sleep 0.05
	end

	def setCursorCoords(y,x)
		(x<0||y<0||y>1||x>19)&&raise("Out of bounds")
		setCursorChar(y*20+x)
	end

	def print(s)
		@socket.print(convertStr(s))
		@cursor += s.length
		@cursor %= 40
		#sleep 0.05
	end

	def setChar(c)
		@socket.print(convertStr(c[0]))
		setCursorChar(@cursor)
	end

	def backspace(c=1)
		c.times do
			@cursor-=1
			setCursorChar(@cursor)
			setChar(" ")
		end
	end

	def fancy(s)
		
	end

	def close
		@socket.close
	end

end