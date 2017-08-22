#!/usr/bin/gnuplot -persist
set terminal postscript eps size 3.3in,1.5in enhanced color font 'Serif'
set output "FlashR-vs-RRO.eps"

set boxwidth 1 relative
set ylabel 'Normalized Runtime'
set style fill pattern border
set key left top
set key outside above horizontal
plot "./FlashR.vs.RRO.txt" using 2: xtic(1) title "FlashR-IM" with histogram ls 1 lc "green", \
		 "./FlashR.vs.RRO.txt" using 3: xtic(1) title "FlashR-EM" with histogram ls 1 lc "green", \
		 "./FlashR.vs.RRO.txt" using 4: xtic(1) title "RRO" with histogram ls 1 lc "orange"
