#!/bin/bash
rm -f gnuplot.rot
for ((z=0; z<=360; z=z+5))
do
cat >> gnuplot.rot <<!
zrot=$z
zview(zrot)=zrot
set view xview(xrot), zview(zrot), 2, 1
set size square
set view xview(xrot), zview(zrot), 2, 1
set size square
splot cos(u)*cos(v),cos(u)*sin(v),sin(u) notitle with lines lt 5, \
      'world10.dat' notitle with lines lt 3 lw 1     
!
done

echo "Now Plotting"


gnuplot<<!
set term gif transparent nocrop enhanced animate delay 20 loop 0 nooptimize size 600,600 background rgb 'white' font "verdana,12"
set output "globe.gif"
unset title
unset key
unset xtics
unset ytics
set border 0
set hidden3d nooffset
set parametric
set angles degrees
set samples 128,128
set isosamples 13,13
set mapping spherical
set dummy u,v
set urange [ -90.0000 : 90.0000 ] noreverse nowriteback
set vrange [ 0.00000 : 360.000 ] noreverse nowriteback
set style data line
xrot=90
xview(xrot)=xrot
load "gnuplot.rot"
!
