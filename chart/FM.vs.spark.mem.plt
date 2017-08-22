#!/usr/bin/gnuplot -persist
set terminal postscript eps size 3.3in,1.3in enhanced color
set output "FM-vs-spark-mem.eps"

set boxwidth 1 relative
set ylabel 'Memory (GB)'
set style fill pattern border
set nokey
#set key outside above horizontal
set yrange [0:450]
#set logscale y 10
#set xtics rotate by -20
plot "./FM.vs.spark.mem.txt" using 2: xtic(1) title "FM-IM" with histogram, \
		 "./FM.vs.spark.mem.txt" using 3: xtic(1) title "FM-EM" with histogram, \
		 "./FM.vs.spark.mem.txt" using 4: xtic(1) title "MLlib" with histogram
