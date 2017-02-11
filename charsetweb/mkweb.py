with open('index.html', 'w') as web:
	web.write('<body style="background-color:black;">')
	for x in range(0x11, 255):
		web.write('''<div style="width: 76px; height: 140px; color:white; font-weight: bold; float:left; font-size:20px;"><img src="cropped_%i.jpg" width="50%%"><br/>%i</div>''' % (x, x))

	web.write('</body>')
