#!/usr/bin/gnuplot -persist
set terminal postscript eps size 3.3in,1.5in enhanced color
set output "FM-vs-spark.eps"

set boxwidth 1 relative
set ylabel 'Runtime (s)'
set style fill pattern border
set key left top
set key outside above horizontal
set yrange [0.1:1500]
set logscale y 10
#set xtics rotate by -20
plot "./FM.vs.spark.txt" using 2: xtic(1) title "FM-IM" with histogram, \
		 "./FM.vs.spark.txt" using 3: xtic(1) title "FM-EM" with histogram, \
		 "./FM.vs.spark.txt" using 4: xtic(1) title "MLlib" with histogram
