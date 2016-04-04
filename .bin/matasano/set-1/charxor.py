import sys
import argparse

if __name__ == '__main__':

	parser = argparse.ArgumentParser()
	parser.add_argument('-c', type=int, required=True, help='The ASCII value of the key', metavar='int')
	parser.add_argument('-t', required=True, help='The plaintext to be encrypted', metavar='string')

	values = parser.parse_args()

	print("".join(chr(ord(x)^values.c) for x in values.t))
