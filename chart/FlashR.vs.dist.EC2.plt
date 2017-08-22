#!/usr/bin/gnuplot -persist
set terminal postscript eps size 3.3in,1.5in enhanced color font 'Serif'
set output "FlashR-vs-dist-EC2.eps"

set boxwidth 1 relative
set ylabel 'Normalized Runtime'
set style fill pattern border
set key left top
set key outside above horizontal
#set yrange [0:5]
set xtics rotate by -10
plot "./FlashR.vs.dist.EC2.txt" using 2: xtic(1) title "FlashR-IM" with histogram ls 1 lc "green", \
		 "./FlashR.vs.dist.EC2.txt" using 3: xtic(1) title "FlashR-EM" with histogram ls 1 lc "green", \
		 "./FlashR.vs.dist.EC2.txt" using 4: xtic(1) title "H_2O" with histogram ls 1 lc "red", \
		 "./FlashR.vs.dist.EC2.txt" using 5: xtic(1) title "MLlib" with histogram ls 1 lc "purple" fill pattern 4
