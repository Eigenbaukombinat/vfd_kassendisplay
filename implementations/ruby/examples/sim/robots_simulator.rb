Dir.chdir("../..")
load 'libvfd-ebk.rb'
vfd = EbkVfd.new("127.0.0.1",2323)
vfd.print("Я TBOЙ CЛУГa\nЯ TBOЙ pa6oTHИK") # from Kraftwerk - The Robots
vfd.close
