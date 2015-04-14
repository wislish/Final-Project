function [x1,y1]=utmreverse(x,y)
axesm utm
Z='50S';
setm(gca,'zone',Z)
h = getm(gca);

[x1,y1]= minvtran(h,x,y);

