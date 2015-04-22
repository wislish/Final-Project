function [newusers] = adaptiveinterval(usersRoute,iniArea,k_threshold)
% Location 3-Anonymity example
% Define some parameters for the Adaptive-Interval Algorithm
numOfRecord=0;

% testusers=translateNewInterval(testusers);
testusers=usersRoute;
newusers = testusers;
usersUTM=utmprojection(testusers);
% Begin cloaking
for i=1:length(testusers)
    
    newUserRoute = testusers{i,1};
    for routeNum=1:size(newUserRoute,1)
        
        user = newUserRoute{routeNum,1};
        userutm=usersUTM{i,1}{routeNum,1};
        for j=1:length(user{3,1})
            disp([i,routeNum,j]);
            if user{1,1}(j) == 0
                continue;
            end
            recordNeighbor=zeros(3,182);
            oldNeighbor=[];
            neighbor=[];
            k_neighbor=0;
            old_k=0;
            q=iniArea;
            q_prev=q;
            userx = userutm(j,1);
            usery = userutm(j,2);
            %             starttime = datenum(user{3,1}(j));
            %             endtime = datenum(user{4,1}(j));
            %         anonymizer should not be created each single time.!!
            [cenX,cenY] = anonymizer(userx,usery,iniArea);
            
            originside = (sqrt(iniArea)/2)*1000;
            upperLeft = [cenX-originside,cenY+originside];
            upperRight = [cenX+originside,cenY+originside];
            lowerLeft = [cenX-originside,cenY-originside];
            lowerRight = [cenX+originside,cenY-originside];
            newzone=[upperLeft;upperRight;lowerLeft;lowerRight];
            turnOfIncreasing=0;
            while true
                turnOfIncreasing=turnOfIncreasing+1;
                disp('newzone calculation:');
                %  search neighbor in already existed neighbors
                for l=1:length(testusers)
                    if l==i
                        continue;
                    end
%                     disp(l);
                    if turnOfIncreasing ~=1
                        if any(ismember(oldNeighbor(1,:),l))==0
                            continue;
                        end
                    end
                    otherUserRoute = testusers{l,1};
                    for routeNum2=1:size(otherUserRoute,1)
                        
                        if turnOfIncreasing ~=1
                            if any(ismember(oldNeighbor(2,:),routeNum2))==0
                                continue;
                            end
                        end
                        
                        checkuser = otherUserRoute{routeNum2,1};
                        checkuserutm=usersUTM{l,1}{routeNum2,1};
                        for m=1:length(checkuser{3,1})
                            if turnOfIncreasing ~=1
                                if any(ismember(oldNeighbor(3,:),m))==0
                                    continue;
                                end
                            end
                            if checkuser{1,1}(m) == 0
                                continue;
                            end
                            tuserx=checkuserutm(m,1);
                            tusery=checkuserutm(m,2);
                            %                             tstarttime = datenum(checkuser{3,1}(m));
                            %                             tendtime = datenum(checkuser{4,1}(m));
                            %                     if (endtime>tstarttime && starttime <tstarttime && ((tendtime-starttime)<4*(endtime-tstarttime))) || (starttime>tstarttime && starttime<tendtime && ((endtime-tstarttime)<4*(tendtime-starttime)))
                            %                             if (endtime>=tstarttime && starttime <=tstarttime ) || (starttime>=tstarttime && starttime<=tendtime)
                            if tuserx > newzone(1,1) && tuserx<newzone(2,1) && tusery>newzone(3,2) && tusery < newzone(2,2)
%                                 disp('neighbor+1');
                                k_neighbor=k_neighbor+1;
                                recordNeighbor(1,k_neighbor)=l;
                                recordNeighbor(2,k_neighbor)=routeNum2;
                                recordNeighbor(3,k_neighbor)=m;
                                
                                break;
                            end
                            %                             end
                        end
                    end
                end
%                 disp('k_neighbor');
%                 disp(k_neighbor);
                if k_neighbor<k_threshold
                    neighbor = oldNeighbor;
                    break;
                end
                
                oldNeighbor=recordNeighbor;
                old_k=k_neighbor;
                k_neighbor=0;
                recordNeighbor=zeros(3,182);
                
                q_prev = q;
                q=q_prev/4;
                newzone=createNewZone(userx,usery,newzone,q,iniArea);
            end
            disp('odl_k');
            disp(old_k);
            
            %       delete k_neighbor cell
            
            if old_k >=k_threshold
                disp('find!!');
                numOfRecord=numOfRecord+1;
                disp(numOfRecord);
                %        x,y change to the centre of the newzone.
                %%%%%%%%%%%%%%%%%%%
                newX=(newzone(1,1)+newzone(2,1))/2;
                newY=(newzone(1,2)+newzone(3,2))/2;
                [newLat,newLon] = utmreverse(newX,newY);
                for n=1:2
                    testusers{i,1}{routeNum,1}{n,1}(j)=0;
                end
                usersUTM{i,1}{routeNum,1}(j,:)=0;
                newusers{i,1}{routeNum,1}{1,1}(j) = newLat;
                newusers{i,1}{routeNum,1}{2,1}(j) = newLon;
                %             else
                %                 %  mark '*'
                %                 disp('no enough neighbors!!');
                %                 newusers{l,1}{1,1}(m)=0;
                %                 newusers{l,1}{2,1}(m)=0;
                for num = 1:old_k
                    l=oldNeighbor(1,num);
                    routeNum2=oldNeighbor(2,num);
                    m=oldNeighbor(3,num);
                    
                    for n=1:2
                        testusers{l,1}{routeNum2,1}{n,1}(m)=0;
                    end
                    
                    usersUTM{l,1}{routeNum2,1}(m,:)=0;
                    newusers{l,1}{routeNum2,1}{1,1}(m) = newLat;
                    newusers{l,1}{routeNum2,1}{2,1}(m) = newLon;
                end
                
            else
                for n=1:2
                    testusers{i,1}{routeNum,1}{n,1}(j)=0;
                end
                usersUTM{i,1}{routeNum,1}(j,:)=0;
                
            end
            
            
        end
    end
    
end
