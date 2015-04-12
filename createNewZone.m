function [newzone] = createNewZone(userx,usery,oldzone,q,iniArea)

dis = (sqrt(iniArea)*(sqrt(2))*1000)^2;
newPoint=[];
flag=0;

for i = 1:4
    if dis > ((userx-oldzone(i,1))^2+(usery-oldzone(i,2))^2)
        dis = (userx-oldzone(i,1))^2+(usery-oldzone(i,2))^2;
        newPoint=[oldzone(i,1),oldzone(i,2)];
        flag=i;
    end
end

side = sqrt(q)*1000;

switch flag
    case 1
        upperLeft=[newPoint(1),newPoint(2)];
        upperRight = [newPoint(1)+side,newPoint(2)];
        lowerLeft = [newPoint(1),newPoint(2)-side];
        lowerRight =  [newPoint(1)+side,newPoint(2)-side];
    case 2
        upperLeft=[newPoint(1)-side,newPoint(2)];
        upperRight = [newPoint(1),newPoint(2)];
        lowerLeft = [newPoint(1)-side,newPoint(2)-side];
        lowerRight =  [newPoint(1),newPoint(2)-side];
    case 3
        upperLeft=[newPoint(1),newPoint(2)+side];
        upperRight = [newPoint(1)+side,newPoint(2)+side];
        lowerLeft = [newPoint(1),newPoint(2)];
        lowerRight =  [newPoint(1)+side,newPoint(2)];
    case 4
        upperLeft=[newPoint(1)-side,newPoint(2)+side];
        upperRight = [newPoint(1),newPoint(2)+side];
        lowerLeft = [newPoint(1)-side,newPoint(2)];
        lowerRight =  [newPoint(1),newPoint(2)];
end
newzone=[upperLeft;upperRight;lowerLeft;lowerRight];

