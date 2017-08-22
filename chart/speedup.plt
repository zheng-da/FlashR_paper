#!/usr/bin/gnuplot -persist
set terminal postscript eps size 3.3in,2.5in enhanced color
set output "speedup.eps"

#set ylabel ''
set xlabel 'The number of threads'
set boxwidth 1 relative
set style fill pattern border
set yrange [1:48]
#set key left top
set key outside above horizontal
set logscale y 2
#set xtics rotate by -20
plot "./speedup.txt" using 2: xtic(1) title "summary-IM" with l, \
		 "./speedup.txt" using 3: xtic(1) title "cor-IM" with l, \
		 "./speedup.txt" using 4: xtic(1) title "SVD-IM" with l, \
		 "./speedup.txt" using 5: xtic(1) title "KMeans-IM" with l, \
		 "./speedup.txt" using 6: xtic(1) title "GMM-IM" with l, \
		 "./speedup.txt" using 7: xtic(1) title "summary-EM" with lp, \
		 "./speedup.txt" using 8: xtic(1) title "cor-EM" with lp, \
		 "./speedup.txt" using 9: xtic(1) title "SVD-EM" with lp, \
		 "./speedup.txt" using 10: xtic(1) title "KMeans-EM" with lp, \
		 "./speedup.txt" using 11: xtic(1) title "GMM-EM" with lp
