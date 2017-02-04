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
import org.apache.spark.mllib.stat.Statistics
import org.apache.spark.mllib.util.MLUtils
import org.apache.spark.mllib.linalg.Vectors

/**
 * An example app for summarizing multivariate data from a file. Run with
 * {{{
 * bin/run-example org.apache.spark.examples.mllib.Correlations
 * }}}
 * By default, this loads a synthetic dataset from `data/mllib/sample_linear_regression_data.txt`.
 * If you use it as a template to create your own app, please use `spark-submit` to submit your app.
 */
object Correlations {

  def main(args: Array[String]) {
    val conf = new SparkConf().setAppName(s"Correlations")
    val sc = new SparkContext(conf)

    val examples = sc.textFile(args(0)).map { line =>
      Vectors.dense(line.split(' ').map(_.toDouble))
    }.cache() // Implies MEMORY_ONLY_SER

    val numExamples = examples.count()

    println(s"numExamples = $numExamples.")

    val startTime = System.currentTimeMillis();
    val corr = Statistics.corr(examples, "pearson")
    val endTime = (System.currentTimeMillis() - startTime)/1000.0;
    println(s"\n\n**Computation time = $endTime sec\n\n")

    sc.stop()
  }
}
// scalastyle:on println
