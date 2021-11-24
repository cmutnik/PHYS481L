# gnuplot script for generating x-ray diffraction stuff
# Corey Mutnik 3/28/16

reset


#set terminal epslatex size 3.5,2.62 color colortext 
#set out 'testeps.tex'

set title('NaCl: n=1')
set ylabel('Intensity [counts]')
set xlabel('2$\theta$ [deg]')

#set key top left
set xrange[20:45]


q(x) = A3*exp(-0.5*((x-o3)/s3)**2)+c3
A3=140;# height
o3=32;# peak center
c3=10;# continuum
s3=10;# width
fit [20:40] q(x) 'NaCl.dat' u 1:($4-$2) via A3,o3,s3,c3

f(x) = A2*exp(-0.5*((x-o2)/s2)**2)+c2
A2=140;# height
o2=32;# peak center
c2=10;# continuum
s2=10;# width
fit [20:40] f(x) 'NaCl.dat' u 1:($3-$2) via A2,o2,s2,c2
#fit [25:35] f(x) 'nacl_por.dat' u 1:($3-$2) via A2,o2,s2,c2

f2(x) = A22*exp(-0.5*((x-o22)/s22)**2)+c22
A22=140;# height
o22=27;# peak center
c22=20;# continuum
s22=4;# width
fit [20:29] f2(x) 'NaCl.dat' u 1:($3-$2) via A22,o22,s22,c22

plot 'NaCl.dat' u 1:($3-$2):($3-$2)**0.5 ps 2 lc rgb '#0000FF' t '' w yerrorbars, \
	'NaCl.dat' u 1:($4-$2):($4-$2)**0.5 ps 2 lc rgb '#32CD32' t '' w yerrorbars, \
	q(x) lw 2 lc rgb '#32CD32' t 'Ni Filter', \
	f(x) lw 2 lc rgb '#0000FF' t 'No Filter', \
	f2(x) lw 2 lc rgb '#0000FF' t ''

set output