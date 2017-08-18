vecs <- fm.load.dense.matrix(c("/mnt/nfs/zhengda/data/Criteo/day_0.gz", "/mnt/nfs/zhengda/data/Criteo/day_1"), in.mem=TRUE, ele.type=c(rep("I", 14), rep("X", 16)), delim="\t")

# The steps for setting up the testing environment.
library(FlashRLearn)
fm.set.conf("matrix/conf/run_test-EM.txt")
data <- fm.get.dense.matrix("Criteo_2days.mat")
fm.set.test.na(FALSE)

source("FlashR-learn/R/grad.desc.R")
source("FlashR-learn/R/classification.R")
train.data <- fm.conv.store(scale(as.double(data[,2:40])), in.mem=TRUE)
res <- logistic.regression(train.data, data[,1], method="Newton")
res <- logistic.regression(fm.conv.store(train.data, in.mem=TRUE), fm.conv.store(data[,1], in.mem=TRUE), method="GD")

for (i in 1:5) {start <- Sys.time(); res <- cor(as.double(data)); end <- Sys.time(); print(end - start)}
for (i in 1:5) {start <- Sys.time(); res <- prcomp(as.double(data), retx=FALSE); end <- Sys.time(); print(end - start)}
start <- Sys.time(); res <- fm.kmeans(as.double(data), 10, 10, use.blas=TRUE); end <- Sys.time(); print(end - start)
for (i in 1:5) {start <- Sys.time(); res <- naiveBayes.train(as.double(data[,2:40]), data[,1]); end <- Sys.time(); print(end - start)}

