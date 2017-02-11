from PIL import Image

testimg = Image.open('charsetweb/cropped_111.jpg')
onewidth, oneheight = testimg.size 

def mk_preview(txt):
	resultsize = (onewidth * len(txt), oneheight)
	result = Image.new('RGB', resultsize)
	index = 0
	for cr in txt:
		single = Image.open('charsetweb/cropped_%i.jpg' % ord(cr))
		result.paste(im=single, box=(index*onewidth, 0))
		index += 1	
	result.save('res.jpg')