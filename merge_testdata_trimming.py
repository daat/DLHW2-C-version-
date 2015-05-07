

def sequence_trimming(list_of_label):
	#list of label(of int type)
	len_list = len(list_of_label)
	#list of index of labels to delete
	del_list = []
	first_non_sil_occur = 0
	last_label = -1
	for i in range(len_list):
		label = list_of_label[i]
		if first_non_sil_occur == 0:
			if label == 36: #sil
				del_list.append(i)
				continue
			else: #first non-sil occur!
				first_non_sil_occur = 1
				last_label = label
				continue
		else:
			if label == last_label:
				del_list.append(i)
				continue
			else:
				last_label = label
				continue
	for i in reversed(del_list):
		del list_of_label[i]
	#list_of_label = [value for index, value in enumerate(list_of_label) if index not in del_list]
	if list_of_label[-1] == 36: #delete sil in the end of sequence
		del list_of_label[-1]

def main():

	idx_to_48_dict = {} #tans 0~47 to 48phone
	idx_to_char_dict = {} #tans 0~47 to character
	_48_to_idx_dict = {} #tans 48phone to 0~47
	with open("./phones/48_idx_chr.map") as phonetable:
		for line in phonetable:
			fortyeight, idx, alphabet = line.split()
			idx_to_48_dict[idx] = fortyeight
			idx_to_char_dict[idx] = alphabet
			_48_to_idx_dict[fortyeight] = idx

	_48_to_39_dict = {} #tans 48phone to 39phone
	with open("./phones/48_39.map") as phonetable:
		for line in phonetable:
			fortyeight, thirtynine = line.split()
			_48_to_39_dict[fortyeight] = thirtynine


	with open("./output.kaggle", "w") as outputfile:
		outputfile.write("id,phone_sequence\n")
		with open("./output_men") as menfile:
			for line in menfile:
				sequence_name, phonelist = line.split()[0], line.split()[1:]
				outputlist = [ _48_to_idx_dict[_48_to_39_dict[idx_to_48_dict[i]]] for i in phonelist ]
				sequence_trimming(outputlist)
				outputlist = [ idx_to_char_dict[i] for i in outputlist ]
				#write output
				outputfile.write(sequence_name+",")
				for i in outputlist:
					outputfile.write(i)
				outputfile.write("\n")

		with open("./output_women") as womenfile:
			for line in womenfile:
				sequence_name, phonelist = line.split()[0], line.split()[1:]
				outputlist = [ _48_to_idx_dict[_48_to_39_dict[idx_to_48_dict[i]]] for i in phonelist ]
				sequence_trimming(outputlist)
				outputlist = [ idx_to_char_dict[i] for i in outputlist ]
				#write output
				outputfile.write(sequence_name+",")
				for i in outputlist:
					outputfile.write(i)
				outputfile.write("\n")



if __name__ == "__main__":
    main()
