% set the parameters of the experiment.
time_resolution= 3600;
space_resolution=4;
numOfPoints=3;
originside = (sqrt(space_resolution)/2)*1000;
dateToTimeRatio = 24*60*60;
kRoute=[];
kRouteNum;
uncerUnique;
% newReadData;
% usersRoute = calRoute(users);
% newUserRoute = cell(length(usersRoute),1);
% for i=1:length(usersRoute)
%
%     eachUserRoute = usersRoute{i,1};
%     for j=1:size(eachUserRoute,1)
%         lat=[];
%         lon =[];
%         time=[];
%         for k=1:size(eachUserRoute,2)
%             if eachUserRoute(j,k)==0
%                 continue;
%             end
%             lat = [lat;users{i,1}{1,1}(eachUserRoute(j,k))];
%             lon = [lon;users{i,1}{2,1}(eachUserRoute(j,k))];
%             time= [time;users{i,1}{3,1}(eachUserRoute(j,k))];
%         end
%         newUserRoute{i,1}{j,1}{1,1}=lat;
%         newUserRoute{i,1}{j,1}{2,1}=lon;
%         newUserRoute{i,1}{j,1}{3,1}=time;
%     end
% end
%
% kanonymityUsers = adaptiveinterval(newUserRoute);
% uncertaintyUsers = uncertainty(newUserRoute);
% kanonymityUTM
% uncertainUTM
% begin to compare

for i = 1:length(newUserRoute)
    %     kanonymityUserRoute = usersUTM{i,1};
    %     uncertaintyUserRoute = uncertainUTM{i,1};
    for j=1:size(kanonymityUserRoute,1)
        
        kisUnique=true;
        checkPoints=zeros(2,numOfPoints);
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
            time=datenum(newUserRoute{i,1}{j,1}{3,1}(num))*dateToTimeRatio;
            [cenX,cenY] = anonymizer(userx,usery,space_resolution);
            upperLeft = [cenX-originside,cenY+originside];
            upperRight = [cenX+originside,cenY+originside];
            lowerLeft = [cenX-originside,cenY-originside];
            lowerRight = [cenX+originside,cenY-originside];
            newzone=[newzone;upperLeft,upperRight,lowerLeft,lowerRight];
            timezone = [timezone;time-time_resolution,time+time_resolution];
        end
        
        for k=1:length(newUserRoute)
            if k==i
                continue;
            end
            
            kOtherUserRoute = kanonymityUTM{k,1};
            uncerOtherUserRoute = uncertainUTM{k,1};
            
            for routeNum=1:size(kOtherUserRoute,1)
                checkuserutm=kOtherUserRoute{l,1}{routeNum,1};
                if size(checkuserutm,1)<numOfPoints
                    continue;
                end
                level=1;
                chekcPoints=0;
                for l=1:size(checkuserutm,1)
                    
                    tuserx=checkuserutm(l,1);
                    tusery=checkuserutm(l,2);
                    ttime=datenum(newUserRoute{k,1}{routeNum,1}{3,1}(l))*dateToTimeRatio;
                    
                    if (size(checkuserutm,1)-l+1)<numOfPoints
                        break;
                    end
                    
                    if tuserx > newzone(lever,1) && tuserx<newzone(lever,3) && tusery>newzone(lever,6) && tusery < newzone(lever,4) && ttime>timezone(lever,1) && ttime>timezone(lever,2)
                        checkPoints=1;
                        seq=l;
                        while level<numOfPoints && checkPoints==level
                            level=level+1;
                            seq=seq+1;
                            tuserx=checkuserutm(seq,1);
                            tusery=checkuserutm(seq,2);
                            ttime=datenum(newUserRoute{k,1}{routeNum,1}{3,1}(seq))*dateToTimeRatio;
                            if tuserx > newzone(lever,1) && tuserx<newzone(lever,3) && tusery>newzone(lever,6) && tusery < newzone(lever,4) && ttime>timezone(lever,1) && ttime>timezone(lever,2)
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
            kRouteNum=kRouteNum+1;
            kRoute(1,kRouteNum)=i;
            kRoute(2,kRouteNum)=j;
        end
        
    end
end
