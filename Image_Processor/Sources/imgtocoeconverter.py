import sys
from PIL import Image

def convert (ImageName):

	img = Image.open(ImageName)

	if img.mode != 'RGB':
		img = img.convert(mode='RGB')

	width = img.width;
	height = img.height

	filename = ImageName[:ImageName.find('.')]+'.coe'
	imgcoe = open(filename,'wt')
	imgcoe.write(';	VGA Memory Map\n')
	imgcoe.write('; .COE file with hex coefficients\n')
	imgcoe.write('; Height: {0}, Width: {1}\n'.format(height,width))
	imgcoe.write('memory_initialization_radix = 2;\n')
	imgcoe.write('memory_initialization_vector =\n')

	cnt = 0 
	line_cnt = 0
	for h in range(height):
		for w in range(width):
			cnt += 1

			try:
				R,G,B = img.getpixel((w,h)) 
			except IndexError :
				print ('Index Error Occurred At:')
				print ('h: {}, w:{}'.format(h,w))
				sys.exit()
			
			Rb = bin(R)[2:].zfill(8)
			Gb = bin(G)[2:].zfill(8)
			Bb = bin(B)[2:].zfill(8)	

			try:
				imgcoe.write('{}{}{}'.format(Rb,Gb,Bb))
			except ValueError:
				print ('Value Error Occurred At:')
				print ('Contents at h:{0} w:{1}'.format(h,w))
				print ('R:{0} G:{1} B{2}'.format(R,G,B))
				sys.exit()

			if w==width-1 and h==height-1:
				imgcoe.write(';')
			else:
				imgcoe.write(',\n')
				line_cnt+= 1
	imgcoe.close()
	print( 'Xilinx Coefficients File:{} DONE'.format(filename))
	print( 'Size: h:{} pixels w:{} pixels'.format(height,width))
	print ('COE file is 32 bits wide and {} bits deep'.format(line_cnt))
	print ('Total addresses: {}'.format(width*height))

if __name__ == "__main__" :
	ImageName = input('Enter the name of your image: ')
	convert(ImageName)	

