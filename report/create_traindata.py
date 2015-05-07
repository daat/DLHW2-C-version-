import sys
import collections as cl

def main():

	phonedict = {} #tans 48phone to 0~47
	with open("./phones/48_idx_chr.map") as phonetable:
		for line in phonetable:
			fortyeight, idx, alphabet = line.split()
			phonedict[fortyeight] = int(idx)

	labeldict = {} #framename => its label
	with open("./label/train.lab") as inputlabel:
		for line in inputlabel:
			key, value = line.strip().split(",")
			labeldict[key] = phonedict[value]

	with open("./traindata_partb", "w") as output:
		with open("./fbank/train.ark") as inputdata: #train data ./fbank/train.ark
			for line in inputdata: #fadg0_si1279_1 2.961075 3.239631 ...69...
				frame = line.split()
				label = labeldict[frame[0]]

				output.write( frame[0]+" "+str(label) )
				del(frame[0])
				for i in frame:
					output.write( " "+i )
				output.write( "\n" )


if __name__ == "__main__":
    main()
