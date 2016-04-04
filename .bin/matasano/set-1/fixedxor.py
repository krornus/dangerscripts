import sys

if __name__ == '__main__':

	if(len(sys.argv) != 3 or len(sys.argv[1]) != len (sys.argv[2])):
		print "Requires two equal-length arguments"
		exit()

	print "".join([format(int(x,16)^int(y,16), 'x') for x,y in zip(sys.argv[1], sys.argv[2])])
