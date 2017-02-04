name := "Simple Project"

version := "1.0"

scalaVersion := "2.10.3"

libraryDependencies += "org.apache.spark" %% "spark-core" % "1.5.0"

libraryDependencies += "org.apache.spark" %% "spark-mllib" % "1.5.0"

resolvers += "Akka Repository" at "http://repo.akka.io/releases/"
