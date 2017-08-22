sources <- list.files("/mnt/nfs/zhengda/data/Criteo", full.names=TRUE)
vecs <- fm.load.list.vecs(sources, in.mem=TRUE, ele.types=c(rep("I", 14), rep("H", 26)), delim="\t")
vecs <- fm.load.dense.matrix(c("/mnt/nfs/zhengda/data/Criteo/day_0.gz", "/mnt/nfs/zhengda/data/Criteo/day_1"), in.mem=TRUE, ele.type=c(rep("I", 14), rep("X", 26)), delim="\t")

# The steps for setting up the testing environment.
library(FlashRLearn)
fm.set.conf("matrix/conf/run_test-EM.txt")
data <- fm.get.dense.matrix("Criteo_2days.mat")
fm.set.test.na(FALSE)

train.data <- fm.conv.store(scale(as.double(data[,2:40])), in.mem=TRUE)
res <- logistic.regression(train.data, data[,1], method="Newton")
res <- logistic.regression(fm.conv.store(train.data, in.mem=TRUE), fm.conv.store(data[,1], in.mem=TRUE), method="GD")

for (i in 1:5) {start <- Sys.time(); res <- cor(as.double(data)); end <- Sys.time(); print(end - start)}
for (i in 1:5) {start <- Sys.time(); res <- prcomp(as.double(data), retx=FALSE); end <- Sys.time(); print(end - start)}
start <- Sys.time(); res <- fm.kmeans(as.double(data), 10, 10, use.blas=TRUE); end <- Sys.time(); print(end - start)
for (i in 1:5) {start <- Sys.time(); res <- naiveBayes.train(as.double(data[,2:40]), data[,1]); end <- Sys.time(); print(end - start)}

# Construct the Criteo dataset.
library(FlashR)
fm.set.conf("matrix/conf/run_test-EM.txt")
sources <- list.files("/mnt/nfs/zhengda/data/Criteo", full.names=TRUE)
vecs <- fm.load.list.vecs(sources, in.mem=FALSE, ele.types=c(rep("I", 14), rep("H", 26)), delim="\t", name="Criteo-all.mat")
for (i in 15:40) vecs[[i]] <- fm.as.factor(vecs[[i]])
newdata <- fm.cbind.list(vecs)


# Run logistic regression on the entire Criteo dataset.
library(FlashRLearn)
fm.set.conf("matrix/conf/run_test-EM.txt")
data <- fm.get.dense.matrix("Criteo_all_trans.mat")
y <- data[,1]
x <- data[,2:40]
source("FlashR-learn/R/classification.R")
fm.set.test.na(FALSE)
res <- logistic.regression(x, y, method="L-BFGS-B", max.iters=100)

# Run GMM on the 32 singular vectors.
library(FlashRLearn)
fm.set.conf("matrix/conf/run_test-EM.txt")
fm.set.test.na(FALSE)
mat1 <- fm.get.dense.matrix("pg-tmp2-lcc.mat")
mat2 <- fm.get.dense.matrix("pg-tmp2-lcc2.mat")
mat3 <- fm.get.dense.matrix("pg-tmp2-lcc-left.mat")
mat4 <- fm.get.dense.matrix("pg-tmp2-lcc2-left.mat")
mat <- cbind(mat1, mat2, mat3, mat4)
load("/mnt/nfs2/zhengda/pg-tmp2-lcc-evals1.Rdata")
load("/mnt/nfs2/zhengda/pg-tmp2-lcc-evals2.Rdata")
svals <- sqrt(c(evals1, evals2))
data <- fm.mapply.row(mat, sqrt(c(svals, svals)), "*")
source("FlashR-learn/R/GMM.R")
res <- GMM.fit(data, k=10, max.iter=100, tol=0.01)
