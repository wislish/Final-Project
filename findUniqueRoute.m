function[Route] = findUniqueRoute(kanonymityUsers,numOfPoints,space_resolution,time_resolution)

originside = (sqrt(space_resolution)/2)*1000;
dateToTimeRatio = 24*60*60;
Route=[];
RouteNum=0;

kanonymityUTM = utmprojection(kanonymityUsers);
disp('begin to find!!!!!!!!!!!!!!!!')
for i = 1:length(kanonymityUsers)
        kanonymityUserRoute = kanonymityUTM{i,1};
    for j=1:size(kanonymityUserRoute,1)
        
        kisUnique=true;
        kuser = kanonymityUserRoute{j,1};
        points = size(kuser,1);
        if numOfPoints>points
            continue;
        end
        
        lastStartPoint = points-numOfPoints+1;
        startLocation = randi(lastStartPoint,1);
        neighbor=[];
        newzone=[];
        timezone=[];
        
        for num=startLocation:(startLocation+numOfPoints-1)
            
            userx=kuser(num,1);
            usery=kuser(num,2);
            time=datenum(kanonymityUsers{i,1}{j,1}{3,1}(num))*dateToTimeRatio;
            [cenX,cenY] = anonymizer(userx,usery,space_resolution);
            upperLeft = [cenX-originside,cenY+originside];
            upperRight = [cenX+originside,cenY+originside];
            lowerLeft = [cenX-originside,cenY-originside];
            lowerRight = [cenX+originside,cenY-originside];
            newzone=[newzone;upperLeft,upperRight,lowerLeft,lowerRight];
            timezone = [timezone;time-time_resolution,time+time_resolution];
        end
        
        for k=1:length(kanonymityUsers)
            if k==i
                continue;
            end
            
            OtherUserRoute = kanonymityUTM{k,1};
            
            for routeNum=1:size(OtherUserRoute,1)
                checkuserutm=OtherUserRoute{routeNum,1};
                if size(checkuserutm,1)<numOfPoints
                    continue;
                end
                level=1;
                checkPoints=0;
                for l=1:size(checkuserutm,1)
                    
                    tuserx=checkuserutm(l,1);
                    tusery=checkuserutm(l,2);
                    ttime=datenum(kanonymityUsers{k,1}{routeNum,1}{3,1}(l))*dateToTimeRatio;
                    
                    if (size(checkuserutm,1)-l+1)<numOfPoints
                        break;
                    end
                    
                    if tuserx > newzone(level,1) && tuserx<newzone(level,3) && tusery>newzone(level,6) && tusery < newzone(level,4) && ttime>timezone(level,1) && ttime>timezone(level,2)
                        checkPoints=1;
                        seq=l;
                        while level<numOfPoints && checkPoints==level
                            level=level+1;
                            seq=seq+1;
                            tuserx=checkuserutm(seq,1);
                            tusery=checkuserutm(seq,2);
                            ttime=datenum(kanonymityUsers{k,1}{routeNum,1}{3,1}(seq))*dateToTimeRatio;
                            if tuserx > newzone(level,1) && tuserx<newzone(level,3) && tusery>newzone(level,6) && tusery < newzone(level,4) && ttime>timezone(level,1) && ttime>timezone(level,2)
                                checkPoints=checkPoints+1;
                            end
                        end
                        if checkPoints==numOfPoints
                            kisUnique=false;
                            break;
                        end
                    end
                    if kisUnique==false
                        break;
                    end
                    
                end
                if kisUnique==false
                    break;
                end
            end
            if kisUnique==false
                break;
            end
            
        end
        if kisUnique==false
            RouteNum=RouteNum+1;
            Route(1,RouteNum)=i;
            Route(2,RouteNum)=j;
            
        end
        
    end
end