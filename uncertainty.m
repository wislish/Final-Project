function [newusers] = uncertainty(usersRoute,iniArea,coverage)
% uncertain region, equal  to iniArea of adaptive interval.
% square area, like in the adpative
% initial privacy
uncertain_area=iniArea;
sensitive_area = uncertain_area*coverage;

testusers = usersRoute;
newusers = testusers;
usersUTM=utmprojection(testusers);
disp('begin to uncertainty!!!!!!!!!!!!!!!!!!!!!!!!');
for i=1:length(testusers)
    disp(i);
    newUserRoute = testusers{i,1};
    for routeNum=1:size(newUserRoute,1)
        
        user = newUserRoute{routeNum,1};
        userutm=usersUTM{i,1}{routeNum,1};
        for j=1:length(user{3,1})
            userx = userutm(j,1);
            usery = userutm(j,2);
            [cenX,cenY] = anonymizer(userx,usery,iniArea);
            originside = (sqrt(iniArea)/2)*1000;
            upperLeft = [cenX-originside,cenY+originside];
            upperRight = [cenX+originside,cenY+originside];
            lowerLeft = [cenX-originside,cenY-originside];
            lowerRight = [cenX+originside,cenY-originside];

            newX=upperLeft(1)+rand(1)*2*originside;
            newY=lowerLeft(2)+rand(1)*2*originside;
            [newLat,newLon] = utmreverse(newX,newY);
            newusers{i,1}{routeNum,1}{1,1}(j) = newLat;
            newusers{i,1}{routeNum,1}{2,1}(j) = newLon;
        end
    end
end



