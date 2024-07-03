from PIL import Image
import sys
import numpy

def converttoimg (filename):
	rgb = 'xoxoxo'
	imgdata=[]
	file = open(filename,'r')
	fileline = file.readlines()
	for line in fileline[5:] :
		rgbtuple=(int(line[:8],2),int(line[8:16],2),int(line[16:24],2))
		imgdata.append(rgbtuple)

	OUTPUT_IMAGE_SIZE = (160,115)
	image = Image.new('RGB', OUTPUT_IMAGE_SIZE)
	image.putdata(imgdata)
	image.save("newimage.png")

if __name__ == '__main__':
	filename = input('Enter the name of .ceo file:{}')
	converttoimg(filename)			


		


	