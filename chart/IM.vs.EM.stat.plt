#!/usr/bin/gnuplot -persist
set terminal postscript eps size 1.6in,1.5in enhanced color font 'Serif'
set output "IM-vs-EM-stat.eps"

set xlabel 'p'
set ylabel 'IM runtime / EM runtime'
set yrange [0:1]
set key outside above horizontal
plot "./IM.vs.EM.stat.txt" using 2: xtic(1) title "Corr" with lp, \
		 "./IM.vs.EM.stat.txt" using 3: xtic(1) title "NaiveBayes" with lp
