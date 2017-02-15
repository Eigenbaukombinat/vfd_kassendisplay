require 'gtk3'
require 'socket'
require 'timeout'

$builder = Gtk::Builder.new(:file=>"interface.ui")
mainwindow = $builder.get_object("mainwindow")
mainwindow.signal_connect("destroy"){Gtk.main_quit}
0.upto(39){|c|$builder.get_object("chr#{c}").file = File.expand_path("img/cropped_32.jpg")}

$cursor = 0

$refresh_cursor = lambda do 
	$builder.get_object("chr#{$cursor}").file = File.expand_path("img/cropped_95.jpg")
end

$scroll_up = lambda do 	
	0.upto(19) do |o|
		$builder.get_object("chr#{o}").file    = $builder.get_object("chr#{20+o}").file
		$builder.get_object("chr#{20+o}").file = File.expand_path("img/cropped_32.jpg")
	end
	$refresh_cursor.call
end

def clear
	0.upto(39){|c|$builder.get_object("chr#{c}").file = File.expand_path("img/cropped_32.jpg")}
	$cursor = 0
	$refresh_cursor.call
end

def print_vfd(s="")
	s.split("").each_with_index do |i,ind|
		if i=="\n"
			$builder.get_object("chr#{$cursor}").file = File.expand_path("img/cropped_32.jpg")

			if $cursor>=20
				$scroll_up.call
			else
				$builder.get_object("chr#{$cursor}").file = File.expand_path("img/cropped_32.jpg")
			end
			$cursor = 20

		else
			$builder.get_object("chr#{$cursor}").file = File.expand_path("img/cropped_#{i.ord}.jpg")
			$cursor += 1
		end
		if $cursor==40
			$cursor = 20
			$scroll_up.call
		end
	end
	$refresh_cursor.call
end

$refresh_cursor.call # set initial '_' (cursor character)

$PORT = ARGV.shift
$PORT||=2323
$PORT = $PORT.to_s

server = TCPServer.new($PORT)

puts ">> HOSTING SERVER ON 127.0.0.1:#{$PORT}"

Thread.new do # listener thread for sockets
	loop do
		c = server.accept
		cmdmode = false
		begin
			ch = c.read_nonblock(1)
			if cmdmode
				if ch.ord>=0&&ch.ord<40
					$builder.get_object("chr#{$cursor}").file = File.expand_path("img/cropped_32.jpg")
					$cursor=ch.ord
					#0.upto(39){|c|$builder.get_object("chr#{c}").file = File.expand_path("img/cropped_32.jpg")}
					$refresh_cursor.call
				end
				cmdmode = false
			elsif ch=="\x10"
				cmdmode = true
			else
				print_vfd(ch)
			end
			raise IO::EAGAINWaitReadable
		rescue IO::EAGAINWaitReadable
			retry
		rescue EOFError
			# nothing, simply end this and accept the next client
		end
	end
end

mainwindow.title = "EbkVfd Simulator - BETA 0.5"

=begin
Thread.new do 
	starttext = TCPSocket.new("127.0.0.1", $PORT)
	starttext.print("EbkVfd Sim v0.5b\n(c)sesshomariu 2017")
	sleep 4
	starttext.print("\x10\x14\n\n\x10\x00Ready.")
	sleep 1.25
	starttext.print("\x10\x14\n\n\x10\x00")
	starttext.close
end
=end

Gtk.main
puts ">> CLOSING SERVER"
server.close