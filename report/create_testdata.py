import sys
import collections as cl

def main():

	with open("./testdata_partb", "w") as output:
		with open("./fbank/test.ark") as inputdata: #train data ./fbank/train.ark
			for line in inputdata: #fadg0_si1279_1 2.961075 3.239631 ...69...
				frame = line.split()
				output.write( frame[0]+" "+"-1" )
				for i in frame[1:]:
					output.write( " "+i )
				output.write( "\n" )


if __name__ == "__main__":
    main()
