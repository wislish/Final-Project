
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

kanonymityUsers = adaptiveinterval(newUserRoute);

