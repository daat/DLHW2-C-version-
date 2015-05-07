# Makefile for empty SVM-struct API, 03.10.06

#Call 'make' using the following line to make CYGWIN produce stand-alone Windows executables
#		make 'SFLAGS=-mno-cygwin'

#Use the following to compile under unix or cygwin
CC = gcc
LD = gcc

CFLAGS =   $(SFLAGS) -O3 -fomit-frame-pointer -ffast-math -Wall 
LDFLAGS =  $(SFLAGS) -O3 -lm -Wall
#CFLAGS =  $(SFLAGS) -pg -Wall
#LDFLAGS = $(SFLAGS) -pg -lm -Wall 

all: svm_empty_learn svm_empty_classify

.PHONY: clean
clean: svm_light_clean svm_struct_clean
	rm -f *.o *.tcov *.d core gmon.out *.stackdump 

#-----------------------#
#----   SVM-light   ----#
#-----------------------#
svm_light_hideo_noexe: 
	cd svm_light; make svm_learn_hideo_noexe

svm_light_clean: 
	cd svm_light; make clean

#----------------------#
#----  STRUCT SVM  ----#
#----------------------#

svm_struct_noexe: 
	cd svm_struct; make svm_struct_noexe

svm_struct_clean: 
	cd svm_struct; make clean


#-------------------------#
#----  SVM empty API  ----#
#-------------------------#

svm_empty_classify: svm_light_hideo_noexe svm_struct_noexe svm_struct_api.o svm_struct/svm_struct_classify.o svm_struct/svm_struct_common.o svm_struct/svm_struct_main.o 
	$(LD) $(LDFLAGS) svm_struct_api.o svm_struct/svm_struct_classify.o svm_light/svm_common.o svm_struct/svm_struct_common.o -o svm_empty_classify $(LIBS) -lm

svm_empty_learn: svm_light_hideo_noexe svm_struct_noexe svm_struct_api.o svm_struct_learn_custom.o svm_struct/svm_struct_learn.o svm_struct/svm_struct_common.o svm_struct/svm_struct_main.o
	$(LD) $(LDFLAGS) svm_struct/svm_struct_learn.o svm_struct_learn_custom.o svm_struct_api.o svm_light/svm_hideo.o svm_light/svm_learn.o svm_light/svm_common.o svm_struct/svm_struct_common.o svm_struct/svm_struct_main.o -o svm_empty_learn $(LIBS) -lm


svm_struct_api.o: svm_struct_api.c svm_struct_api.h svm_struct_api_types.h svm_struct/svm_struct_common.h
	$(CC) -c $(CFLAGS) svm_struct_api.c -o svm_struct_api.o -lm

svm_struct_learn_custom.o: svm_struct_learn_custom.c svm_struct_api.h svm_light/svm_common.h svm_struct_api_types.h svm_struct/svm_struct_common.h
	$(CC) -c $(CFLAGS) svm_struct_learn_custom.c -o svm_struct_learn_custom.o -lm

	
run: output_men output_women
	python merge_testdata_trimming.py

train_men:
	wget https://goo.gl/KNiVTU
	mv KNiVTU train_men
	
test_men:
	wget https://goo.gl/z5jVQT
	mv z5jVQT test_men
	
test_women:
	wget https://goo.gl/dhyUPW 
	mv dhyUPW  test_women

train_women:
	wget https://goo.gl/kjzQ5u
	mv kjzQ5u train_women
	
output_men: menmodel test_men
	./svm_empty_classify ./test_men menmodel output_men
menmodel: train_men
	./svm_empty_learn -c 1 ./train_men menmodel
output_women: womenmodel test_women
	./svm_empty_classify ./test_women womenmodel output_women
womenmodel: train_women
	./svm_empty_learn -c 1 ./train_women womenmodel