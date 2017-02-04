library(h2o)
h2o.init(nthreads=48, max_mem_size="500G")
data <- h2o.importFile("/mnt/nfs/zhengda/data/Criteo/day_1.factor", col.types=c("categorical", rep("double", 29)))
start <- Sys.time(); res <- summary(data); end <- Sys.time(); print(end -start)
start <- Sys.time(); res <- h2o.prcomp(data, k=ncol(data), transform="STANDARDIZE"); end <- Sys.time(); print(end - start)
start <- Sys.time(); res <- h2o.kmeans(data, k=10, max_iterations=10, init="Random"); end <- Sys.time(); print(end - start)

