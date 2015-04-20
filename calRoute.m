function [userRoute] = calRoute(users)

dateToTimeRatio = 24*60*60;
timeThresh = 30*60;  % half hour
breaklimit = 5*60; % the track will be re-started if there exist 5-min break
r = 6400;
disThresh=1;
userRoute = cell(length(users),1);
for i=1:length(users)
    disp(i);
    a=[];
    zoneTrack=[];
    a(1)=1;
    j=1;
    interval=0;
    lastpoint=1;
    user = users{i,1};
    lat = user{1,1};
    lon = user{2,1};
    datetime = user{3,1};
    len = length(lat);
    for eachpoint = 1:len
        
        dis = (pi*distance(lat(eachpoint),lon(eachpoint),lat(a(j,lastpoint)),lon(a(j,lastpoint)))*r)/180;
        breakinterval = (datenum(datetime{eachpoint})-datenum(datetime{max(eachpoint-1,1)}))*dateToTimeRatio;
        
        if dis >=disThresh &&  breakinterval < breaklimit
            lastpoint=lastpoint+1;
            a(j,lastpoint) = eachpoint;
        else
            interval = (datenum(datetime{eachpoint})-datenum(datetime{a(j,lastpoint)}))*dateToTimeRatio;
            if interval >= timeThresh || breakinterval >= breaklimit
                if lastpoint == 1
                    a(j,lastpoint)=eachpoint;
                    continue;
                end
                lastpoint = 1;
                j=j+1;
                a(j,lastpoint)=eachpoint;
                
            end
        end
        
    end
    disp(a);
    userRoute{i,1}=a;
end

