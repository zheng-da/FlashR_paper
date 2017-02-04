# To compile the testing code.
sbt package

# k-means.
../bin/spark-submit  --master local[48] --class org.apache.spark.examples.mllib.DenseKMeans target/scala-2.10/simple-project_2.10-1.0.jar /mnt/nfs/zhengda/data/Criteo/day_1.factor 10 10

# logistic regression
../bin/spark-submit  --master local[48] --class org.apache.spark.examples.mllib.LogisticRegressionWithLBFGSExample target/scala-2.10/simple-project_2.10-1.0.jar /mnt/nfs/zhengda/data/Criteo/day_1.factor
