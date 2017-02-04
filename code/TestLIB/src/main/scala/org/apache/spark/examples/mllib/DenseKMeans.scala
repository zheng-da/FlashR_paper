package org.apache.spark.examples.mllib

import org.apache.log4j.{Level, Logger}

import org.apache.spark.{SparkConf, SparkContext}
import org.apache.spark.mllib.clustering.KMeans
import org.apache.spark.mllib.linalg.Vectors

/**
 * An example k-means app. Run with
 * {{{
 * ./bin/run-example org.apache.spark.examples.mllib.DenseKMeans [options] <input>
 * }}}
 * If you use it as a template to create your own app, please use `spark-submit` to submit your app.
 */
object DenseKMeans {

  object InitializationMode extends Enumeration {
    type InitializationMode = Value
    val Random, Parallel = Value
  }

  import InitializationMode._

  case class Params(
      input: String = null,
      k: Int = -1,
      numIterations: Int = 10,
      initializationMode: InitializationMode = Parallel) extends AbstractParams[Params]

  def main(args: Array[String]) {
    val conf = new SparkConf().setAppName(s"DenseKMeans")
    val sc = new SparkContext(conf)

    Logger.getRootLogger.setLevel(Level.WARN)
    println(args(0))
    println(args(1))
    println(args(2))

    val examples = sc.textFile(args(0)).map { line =>
      Vectors.dense(line.split(' ').map(_.toDouble))
    }.cache() // Implies MEMORY_ONLY_SER
    val numExamples = examples.count()
    println(s"numExamples = $numExamples.")

    val initMode = KMeans.RANDOM
    //val initMode = KMeans.PARALLEL

    val startTime = System.currentTimeMillis();
    val model = new KMeans()
      /*.setInitializationMode(initMode)*/
      .setK(args(1).toInt)
      .setEpsilon(1E-6)
      .setMaxIterations(args(2).toInt)
      .run(examples)
    val endTime = (System.currentTimeMillis() - startTime)/1000.0;
    println(s"\n\n**Computation time = $endTime sec\n\n")

    val cost = model.computeCost(examples)

    println(s"Total cost = $cost.")

    sc.stop()
  }
}
