$:.unshift(File.expand_path(".."))
load 'libvfd-ebk.rb'

x = EbkVfd.new("192.168.21.149")
x.setCursorChar(0)
sleep 5
for ch in "Wake up, Neo...".split("")
	x.print ch
	sleep 0.25
end
sleep 3
x.clear
x.setCursorChar(0)
sleep 1
for ch in "The Matrix has\nyou...".split("")
	x.print ch
	sleep 0.25
end
sleep 5
x.clear
x.setCursorChar(0)
sleep 1
for ch in "Follow the white\nrabbit".split("")
	x.print ch
	sleep 0.25
end
sleep 5
x.clear
x.setCursorChar(0)
