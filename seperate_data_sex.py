
train_men_output = open("./train_men", "w")
train_women_output = open("./train_women", "w")
test_men_output = open("./test_men", "w")
test_women_output = open("./test_women", "w")

with open("./traindata") as traindata:
	for line in traindata:
		if line[0] == "m": #speaker
			train_men_output.write(line)
		elif line[0] == "f":
			train_women_output.write(line)

with open("./testdata_partb") as testdata:
	for line in testdata:
		if line[0] == "m": #speaker
			test_men_output.write(line)
		elif line[0] == "f":
			test_women_output.write(line)
