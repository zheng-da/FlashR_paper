#!/usr/bin/gnuplot -persist
set terminal postscript eps size 1.6in,1.5in enhanced color font 'Serif'
set output "IM-vs-EM-clust.eps"

#set ylabel ''
set xlabel 'k'
set ylabel 'IM runtime / EM runtime'
set yrange [0:1]
set key outside above horizontal
#set xtics rotate by -20
plot "./IM.vs.EM.clust.txt" using 2: xtic(1) title "K-means" with lp
