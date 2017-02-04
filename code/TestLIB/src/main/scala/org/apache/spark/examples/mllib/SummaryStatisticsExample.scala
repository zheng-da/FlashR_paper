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
import org.apache.spark.mllib.linalg.Vectors
import org.apache.spark.mllib.stat.{MultivariateStatisticalSummary, Statistics}
import org.apache.spark.mllib.linalg.Vectors
// $example off$

object SummaryStatisticsExample {

  def main(args: Array[String]): Unit = {

    val conf = new SparkConf().setAppName("SummaryStatisticsExample")
    val sc = new SparkContext(conf)

    // $example on$
    val examples = sc.textFile(args(0)).map { line =>
      Vectors.dense(line.split(' ').map(_.toDouble))
    }.cache() // Implies MEMORY_ONLY_SER
    val numExamples = examples.count()
    println(s"numExamples = $numExamples.")

    // Compute column summary statistics.
    val startTime = System.currentTimeMillis();
    val summary: MultivariateStatisticalSummary = Statistics.colStats(examples)
    val endTime = (System.currentTimeMillis() - startTime)/1000.0;
    println(s"\n\n**Computation time = $endTime sec\n\n")
    println(summary.mean)  // a dense vector containing the mean value for each column
    println(summary.variance)  // column-wise variance
    println(summary.numNonzeros)  // number of nonzeros in each column
    // $example off$

    sc.stop()
  }
}
// scalastyle:on println
