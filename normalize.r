train_data = read.table("fbank/test.ark",row.names=1)

normalize_data = train_data

for(i in 1:69){
  normalize_data[,i] = (normalize_data[,i]-mean(normalize_data[,i]))/sd(normalize_data[,i])
}

write.table(file="fbank/normal_test.ark",x=normalize_data,col.names=F,sep=" ",quote=F)
