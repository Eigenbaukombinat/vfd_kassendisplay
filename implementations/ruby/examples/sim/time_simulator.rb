Dir.chdir("../..")
load 'libvfd-ebk.rb'

vfd = EbkVfd.new("127.0.0.1",2323)
vfd.print("33c3 - Works For Me\nDay 1      #{Time.now.to_s.split[1]}")
sleep 1
loop do
	vfd.setCursorChar(30)
	vfd.print(" "+Time.now.to_s.split[1])
	sleep 1
end

vfd.close
