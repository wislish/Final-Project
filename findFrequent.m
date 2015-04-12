function [] = findFrequent(testdata,lat,lon,filename)
[nrow,ncol] = size(testdata);
zone = [];
zoneTrack = testdata;
r = 6400;
indexOfZone =0;
olddis=r;
patternSet=[];
num=1;
isHas = 0;
for i = 1:nrow
    for j = 1:ncol
        if testdata(i,j)==0
            continue;
        end
         
        if isempty(zone)
            zone(1,1) = lat(testdata(1,1));
            zone(2,1) = lon(testdata(1,1));
        end
        for k = 1:size(zone,2)

            newdis = (pi*distance(lat(testdata(i,j)),lon(testdata(i,j)),zone(1,k),zone(2,k))*r)/180;
            
            if newdis < olddis
                olddis = newdis;
                indexOfZone = k;
            end            
        end
        
        if olddis <= 1
%             zone(1,indexOfZone)= (lat(testdata(i,j))+zone(1,indexOfZone))/2;
%             zone(2,indexOfZone)= (lon(testdata(i,j))+zone(2,indexOfZone))/2;
            zoneTrack(i,j)= indexOfZone;
        else
            zone(1,size(zone,2)+1) = lat(testdata(i,j));
            zone(2,size(zone,2)) = lon(testdata(i,j));
            zoneTrack(i,j) = (size(zone,2));
        end
        olddis =r;
        indexOfZone = 0;        
    end
end 

countSupport = triu(ones(size(zone,2),size(zone,2)),0);
[row,col]=size(countSupport);
for i=1:row
    for j= 1:col
        if i==j || countSupport(i,j)==0
            continue;
        end
        
        for k = 1:size(zoneTrack,1)
            if ismember(i,zoneTrack(k,:)) ==1
               if ismember(j,zoneTrack(k,:))==1
                   countSupport(i,j)=countSupport(i,j)+1;
               end
            end
        end
 
    end

end
[x, y]=find(countSupport==max(max(countSupport)));
fileout='out1.txt';
fid=fopen(fileout,'at+'); 
fprintf(fid,'\n%s %f %f %f %f',filename,zone(1,x(1)),zone(2,x(1)),zone(1,y(1)),zone(2,y(1)));   
fclose(fid); 
disp('finish a user');
% disp(['From [',zone(1,x),' ',zone(2,x),'] to [',zone(1,y),' ',zone(2,y),']']);
