$:.unshift(File.expand_path(".."))
load 'libvfd-ebk.rb'

vfd = EbkVfd.new("192.168.21.149")

vfd.clear
vfd.setCursorChar(0)
vfd.print("Eigenbaukombinat")
sleep 3
vfd.clear
vfd.setCursorChar(0)
vfd.print("Terminal.21")
sleep 3
vfd.clear
vfd.setCursorChar(0)
vfd.print("Noch offen: 00:05")
sleep 1
vfd.setCursorChar(16)
vfd.print("4")
sleep 1
vfd.setCursorChar(16)
vfd.print("3")
sleep 1
vfd.setCursorChar(16)
vfd.print("2")
sleep 1
vfd.setCursorChar(16)
vfd.print("1")
sleep 1
vfd.setCursorChar(16)
vfd.print("0")
sleep 1
vfd.clear
vfd.print("ES ")
sleep 0.6
vfd.print("IST ")
sleep 0.6
vfd.print("ZU ")
sleep 0.6

vfd.clear
vfd.close
