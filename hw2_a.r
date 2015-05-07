data = read.table("fbank/train.ark",nrow=474,row.names=1)

label = read.csv("label/train.lab")

index = which(grepl("faem0_si1392",label[,1])==TRUE)

map = read.table("48_idx_chr.map",row.names=1)

map[,1] = map[,1] + 1

seq = map[as.character(label[index,2]),1]

ob_table = matrix(0 , nrow=48 , ncol=69)
for(i in 1:474){
    ob_table[seq[i],] = ob_table[seq[i],] + as.numeric(data[i,])
}

tr_table = matrix(0,nrow=48,ncol=48)
for(i in 1:474){
    a = seq[i]
    b = seq[i+1]
    tr_table[a,b] = tr_table[a,b] + 1
}

result = as.numeric(c(t(ob_table),t(tr_table)))

name = paste("faem0_si1392_",0:5615,sep="")

submission = cbind(name,result)

colnames(submission) = c("id","feature")

write.csv(file="hw2_a",x=submission,quote=F,row.names=F)