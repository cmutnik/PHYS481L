# gnuplot script for generating x-ray diffraction stuff
# Corey Mutnik 3/28/16

reset

set terminal epslatex size 3.5,2.62 color colortext 
set out 'LiF_n1.tex'

set title('LiF: n=1')
set ylabel('Intensity [counts]')
set xlabel('2$\theta$ [deg]')

set key top left
set xrange[30:50]

q(x) = A3*exp(-0.5*((x-o3)/s3)**2)+c3
A3=700;# height
o3=39;# peak center
c3=150;# continuum
s3=2;# width
fit [35:43] q(x) 'LiF.dat' u 1:($3-$2):($3-$2)**0.5 via A3,o3,s3,c3

f(x) = A2*exp(-0.5*((x-o2)/s2)**2)+c2
A2=1500;# height
o2=43;# peak center
c2=150;# continuum
s2=2;# width
fit [40:50] f(x) 'LiF.dat' u 1:($3-$2):($3-$2)**0.5 via A2,o2,s2,c2

h(x) = A1*exp(-0.5*((x-o1)/s1)**2)+c1
A1=1500;# height
o1=43;# peak center
c1=150;# continuum
s1=2;# width
fit [40:50] h(x) 'LiF.dat' u 1:($4-$2):($4-$2)**0.5 via A1,o1,s1,c1

plot 'LiF.dat' u 1:($3-$2):($3-$2)**0.5 ps 2 lc rgb '#0000FF' t '' w yerrorbars, \
	'Lif.dat' u 1:($4-$2):($4-$2)**0.5 ps 2 lc rgb '#32CD32' t '' w yerrorbars, \
	q(x) lw 2 lc rgb '#0000FF' t 'No Filter', \
	f(x) lw 2 lc rgb '#0000FF' t '', \
	h(x) lw 2 lc rgb '#32CD32' t 'Ni Filter'

set output