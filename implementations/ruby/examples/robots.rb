Dir.chdir("..")
load 'libvfd-ebk.rb'
vfd = EbkVfd.new("192.168.21.149")
vfd.print("Я TBOЙ CЛУГa\nЯ TBOЙ pa6oTHИK") # from Kraftwerk - The Robots
vfd.close
