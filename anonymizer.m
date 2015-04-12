function [x,y] = anonymizer(userx,usery,iniArea)

side = sqrt(iniArea);
longestDistance = side*(sqrt(2)/2);
distance = rand(1,1)*longestDistance;

diff = (distance/longestDistance)*(side/2)*1000;

rand1= round(rand(1,1)+1);
rand2 =round(rand(1,1)+1);

x=userx+((-1)^rand1)*diff;
y=usery+((-1)^rand2)*diff;