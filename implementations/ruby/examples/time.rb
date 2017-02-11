$:.unshift(File.expand_path(".."))
load 'libvfd-ebk.rb'

vfd = EbkVfd.new("192.168.21.149")
vfd.print("33c3 - Works For Me\nDay 1 | #{Time.now.to_s.split[1]}")
sleep 1
loop do
	vfd.setCursorChar(28)
	vfd.print(Time.now.to_s.split[1])
	sleep 1
end

vfd.close
