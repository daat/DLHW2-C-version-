train_data = read.table("fbank/train.ark",row.names=1)

normalize_data = train_data

for(i in 2:70){
  normalize_data[,i] = (normalize_data[,i]-mean(normalize_data[,i]))/sd(normalize_data[,i])
}

write.table(file="fbank/normal_train.ark",x=normalize_data,col.names=F,sep=" ",quote=F)
