/*
 * Licensed to the Apache Software Foundation (ASF) under one or more
 * contributor license agreements.  See the NOTICE file distributed with
 * this work for additional information regarding copyright ownership.
 * The ASF licenses this file to You under the Apache License, Version 2.0
 * (the "License"); you may not use this file except in compliance with
 * the License.  You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

// scalastyle:off println
package org.apache.spark.examples.mllib

import org.apache.spark.SparkConf
import org.apache.spark.SparkContext
// $example on$
import org.apache.spark.mllib.feature.PCA
import org.apache.spark.mllib.linalg.Vectors
import org.apache.spark.mllib.regression.{LabeledPoint, LinearRegressionWithSGD}
import org.apache.spark.mllib.linalg.Vectors
import org.apache.spark.mllib.linalg.distributed.RowMatrix
// $example off$

@deprecated("Deprecated since LinearRegressionWithSGD is deprecated.  Use ml.feature.PCA", "2.0.0")
object PCAExample {

  def main(args: Array[String]): Unit = {

    val conf = new SparkConf().setAppName("PCAExample")
    val sc = new SparkContext(conf)

    // $example on$
    val data = sc.textFile(args(0)).map { line =>
      Vectors.dense(line.split(' ').map(_.toDouble))
    }.cache() // Implies MEMORY_ONLY_SER
    val numExamples = data.count()
    println(s"numExamples = $numExamples.")

    val startTime = System.currentTimeMillis();
    val ndim = data.first().size
    println(s"PCA on dim $ndim\n")
    val pca = new PCA(ndim).fit(data)
    val endTime = (System.currentTimeMillis() - startTime)/1000.0;
    println(s"\n\n**Computation time = $endTime sec\n\n")

    val startTime1 = System.currentTimeMillis();
    val mat = new RowMatrix(data)
    val pc = mat.computePrincipalComponents(ndim)
    val endTime1 = (System.currentTimeMillis() - startTime1)/1000.0;
    println(s"\n\n**Computation time = $endTime sec\n\n")

//    val numIterations = 100
//    val model = LinearRegressionWithSGD.train(training, numIterations)
//    val model_pca = LinearRegressionWithSGD.train(training_pca, numIterations)

//    val MSE = valuesAndPreds.map { case (v, p) => math.pow((v - p), 2) }.mean()
//    val MSE_pca = valuesAndPreds_pca.map { case (v, p) => math.pow((v - p), 2) }.mean()

//    println("Mean Squared Error = " + MSE)
//    println("PCA Mean Squared Error = " + MSE_pca)
    // $example off$

    sc.stop()
  }
}
// scalastyle:on println
