#!/bin/sh

rm cropped_*.jpg 2> /dev/null
cd ../../../charsetweb/
for i in cropped_*.jpg ;do
	convert $i -resize 40x64 ../implementations/simulator/img/$i
	echo "Refreshed $i"
done
