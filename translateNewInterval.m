function [newUsersInterval] = translateNewInterval(users)

dateToTimeRatio = 24*60*60;
breaklimit = 10*60; % the track will be re-started if there exist 10-min break
r = 6400;
newUsersInterval = cell(length(users),1);

 for i=1:length(users)
    
    user = users{i,1};
    lat = user{1,1};
    lon = user{2,1};
    datetime = user{3,1};
    len = length(lat);
    newLat=[];
    newLon=[];
    startTime=[];
    endTime=[];
    lastpoint=1;
    sumLat=0;
    sumLon=0;
    num=0;
    for j = 1:len
        dis = (pi*distance(lat(j),lon(j),lat(lastpoint),lon(lastpoint))*r)/180;
        breakinterval = (datenum(datetime(j))-datenum(datetime(max(j-1,1))))*dateToTimeRatio;
        if dis <=1 &&  breakinterval < breaklimit
            sumLat=sumLat+lat(j);
            sumLon=sumLon+lon(j);
            num=num+1;
        else
            bufferlat=sumLat/num;
            bufferlon=sumLon/num;
            newLat=[newLat;bufferlat];
            newLon=[newLon;bufferlon];
            startTime=[startTime;datetime(lastpoint)];
            endTime = [endTime;datetime(j-1)];
            num=0;
            sumLat=0;
            sumLon=0; 
            lastpoint=j+1;
        end
    end
%     newUsersInterval{1,1}=newLat;
%     newUsersInterval{2,1}=newLon;
%     newUsersInterval{3,1}=startTime;
%     newUsersInterval{4,1}=endTime;
    newUsersInterval{i,1}{1,1}=newLat;
    newUsersInterval{i,1}{2,1}=newLon;
    newUsersInterval{i,1}{3,1}=startTime;
    newUsersInterval{i,1}{4,1}=endTime;
    disp(['This is the user: ',i]);
end