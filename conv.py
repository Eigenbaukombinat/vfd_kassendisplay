
from PIL import Image
import os

for fn in os.listdir():
	if not fn.endswith('.jpg'):
		continue
	img = Image.open(fn)
	width = img.size[0]
	height = img.size[1]
	img2 = img.crop((40, 0, 320, height-30))
	img2.save("cropped_%s" % fn)
