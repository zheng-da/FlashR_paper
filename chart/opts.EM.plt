#!/usr/bin/gnuplot -persist
set terminal postscript eps size 3.3in,1.5in enhanced color font 'Serif'
set output "opts-EM.eps"

set boxwidth 1 relative
set ylabel 'Relative performance'
set style fill pattern border
set key left top
set key outside above horizontal
#set yrange [0:25]
#set logscale y 10
#set xtics rotate by -20
plot "./opts.EM.txt" using 2: xtic(1) title "Base" with histogram ls 1, \
		 "./opts.EM.txt" using 3: xtic(1) title "Mem-fuse" with histogram ls 1, \
		 "./opts.EM.txt" using 4: xtic(1) title "Cache-fuse" with histogram ls 1
