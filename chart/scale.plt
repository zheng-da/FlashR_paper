#!/usr/bin/gnuplot -persist
set terminal tikz size 3.3in,1.8in
set output "scale.tex"

set boxwidth 1 relative
set ylabel 'Runtime (s)'
set style fill pattern border
set key left top
set key outside above horizontal
set yrange [0:200]
#set logscale y 10
#set xtics rotate by -20
plot "./scale.txt" using 2: xtic(1) title "FM-IM" with histogram, \
		 "./scale.txt" using 3: xtic(1) title "FM-EM" with histogram, \
		 "./scale.txt" using 4: xtic(1) title "MLlib" with histogram, \
		 "./scale.txt" using 5: xtic(1) title "R" with histogram
