% set the parameters of the experiment.
time_resolution= 3600; %second
space_resolution=4; %km
numOfPoints=2;% num of points required to recognize a route
k_threshold=2;% k-anonymity requirements 
coverage=1/10; % uncertainty requrements

newReadData;
disp('begin to calculate users routes');
usersRoute = calRoute(users);
newUserRoute = cell(length(usersRoute),1);

for i=1:length(usersRoute)

    eachUserRoute = usersRoute{i,1};
    for j=1:size(eachUserRoute,1)
        lat=[];
        lon =[];
        time=[];
        for k=1:size(eachUserRoute,2)
            if eachUserRoute(j,k)==0
                continue;
            end
            lat = [lat;users{i,1}{1,1}(eachUserRoute(j,k))];
            lon = [lon;users{i,1}{2,1}(eachUserRoute(j,k))];
            time= [time;users{i,1}{3,1}(eachUserRoute(j,k))];
        end
        newUserRoute{i,1}{j,1}{1,1}=lat;
        newUserRoute{i,1}{j,1}{2,1}=lon;
        newUserRoute{i,1}{j,1}{3,1}=time;
    end
end

  disp('uncertianty');
  tic;
  uncertaintyUsers = uncertainty(newUserRoute,space_resolution,coverage);
  toc;
  uncertainTime = toc-tic;
  disp('adaptiveinterval');
  tic
  kanonymityUsers = adaptiveinterval(newUserRoute,space_resolution,time_resolution,k_threshold);
  toc
  kanonymityTime=toc-tic;
  
% begin to compare
baseRoute=findUniqueRoute(newUserRoute,numOfPoints,space_resolution,time_resolution);
kRoute=findUniqueRoute(kanonymityUsers,numOfPoints,space_resolution,time_resolution);
uncerRoute=findUniqueRoute(uncertaintyUsers,numOfPoints,space_resolution,time_resolution);

% analyze and present the result

TotalRouteNum=0;
for num = 1:length(newUserRoute)
    TotalRouteNum=TotalRouteNum+size(newUserRoute{num,1},1);
end
base_uniqueRate=size(baseRoute,2)/TotalRouteNum;
k_uniqueRate=size(kRoute,2)/TotalRouteNum;
uncer_uniqueRate=size(uncerRoute,2)/TotalRouteNum;

%accuracy
