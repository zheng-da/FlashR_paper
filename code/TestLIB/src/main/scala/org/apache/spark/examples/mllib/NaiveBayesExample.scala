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

import org.apache.spark.{SparkConf, SparkContext}
// $example on$
import org.apache.spark.mllib.classification.{NaiveBayes, NaiveBayesModel}
import org.apache.spark.mllib.regression.LabeledPoint
import org.apache.spark.mllib.util.MLUtils
import org.apache.spark.mllib.linalg.Vectors
// $example off$

object NaiveBayesExample {

  def main(args: Array[String]): Unit = {
    val conf = new SparkConf().setAppName("NaiveBayesExample")
    val sc = new SparkContext(conf)
    // $example on$
    // Load and parse the data file.
    val data = sc.textFile(args(0)).map { line =>
        val strs = line.trim.split(' ')
        LabeledPoint(strs(0).toDouble,
            Vectors.dense(strs.takeRight(strs.length - 1).map(_.toDouble)))
    }.cache() // Implies MEMORY_ONLY_SER
    val numExamples = data.count()
    println(s"numExamples = $numExamples.")

    val startTime = System.currentTimeMillis();
    val model = NaiveBayes.train(data, lambda = 1.0, modelType = "multinomial")
    val endTime = (System.currentTimeMillis() - startTime)/1000.0;
    println(s"\n\n**Computation time = $endTime sec\n\n")

    sc.stop()
  }
}

// scalastyle:on println
