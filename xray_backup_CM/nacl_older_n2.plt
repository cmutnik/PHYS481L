# gnuplot script for generating x-ray diffraction stuff
# Corey Mutnik 3/28/16

reset

set terminal epslatex size 3.5,2.62 color colortext 
set out 'NaCl_older.tex'

set title('NaCl: n=2')
set ylabel('Intensity [counts]')
set xlabel('2$\theta$ [deg]')

set key top left
set xrange[55:69]


q(x) = A3*exp(-0.5*((x-o3)/s3)**2)+c3
A3=140;# height
o3=65;# peak center
c3=10;# continuum
s3=2;# width
fit [55:69] q(x) 'nacl.older.dat' u 1:($4-$2) via A3,o3,s3,c3

f(x) = A2*exp(-0.5*((x-o2)/s2)**2)+c2
#A2=140; height
#o2=32; peak center
#c2=10; continuum
#s2=10; width
A2=40;# height
o2=60;# peak center
c2=1;# continuum
s2=2;# width
fit [55:70] f(x) 'nacl.older.dat' u 1:($3-$2) via A2,o2,s2,c2

f2(x) = A1*exp(-0.5*((x-o1)/s1)**2)+c1
A1=34;# height
o1=60;# peak center
c1=10;# continuum
s1=3;# width
fit [59:62] f2(x) 'nacl.older.dat' u 1:($3-$2) via A1,o1,s1,c1

plot 'nacl.older.dat' u 1:($3-$2):($3-$2)**0.5 ps 2 lc rgb '#0000FF' t '' w yerrorbars, \
	'nacl.older.dat' u 1:($4-$2):($4-$2)**0.5 ps 2 lc rgb '#32CD32' t '' w yerrorbars, \
	q(x) lw 2 lc rgb '#32CD32' t 'Ni Filter', \
	f(x) lw 2 lc rgb '#0000FF' t 'No Filter', \
	f2(x) lw 2 lc rgb '#0000FF' t ''

set output