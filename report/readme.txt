First, you need to arrange files and data in this way:

HW2
|-fbank
|     |-test.ark
|     |-train.ark
|
|_label
|     |-train.lab
|
|-phones
|     |-48_39.map
|     |-48_idx_chr.map
|
|-(your svm_struct repository)
|
|
|-create_testdata.py
|-create_traindata.py
|-seperate_data_sex.py

Second, execute command "sh my_script" to get processed data.
Third, type "make" in (your svm_struct repository) to get svm_struct "svm_empty_learn" & "svm_empty_classify".
finally, type "make run" in (your svm_struct repository) and then you will get "output.kaggle".


���]predict��X��output_men�Moutput_women
����./python merge_testdata&trimming.py�N�i�o��i�����W�Ǫ�output.kaggle