fileFolder=fullfile('H:\大学学习\大四上\Projects\code\Geolife Trajectories 1.3\Geolife Trajectories 1.3\Data');
dirOutput=dir(fullfile(fileFolder,'*'));
fileNames={dirOutput.name};
fileNames(:,[1,2])=[];

 for userfile = 1:length(fileNames)
     
    lat=[];
    lon =[];
    date=[];
    time=[];
    file = dir(['H:\大学学习\大四上\Projects\code\Geolife Trajectories 1.3\Geolife Trajectories 1.3\Data\',fileNames{userfile},'\Trajectory\*.plt']);
    
    for n = 1:length(file)
    try
        [blat blon bc3 balt bdateInDays bdate btime] = textread(['H:\大学学习\大四上\Projects\code\Geolife Trajectories 1.3\Geolife Trajectories 1.3\Data\',fileNames{userfile},'\Trajectory\',file(n).name],'%f %f %d %s %f %s %s','delimiter',',','headerlines',6);
        lat = [lat;blat];
        lon = [lon;blon];
        date = [date;bdate];
        time = [time;btime];
    catch exception
        continue;
    end
    end
    len = length(lat);
a =[];
a(1)=1;
j=1;
dateToTimeRatio = 24*60*60;
timeLimit = 45*60;  % half hour
breaklimit = 5*60; % the track will be re-started if there exist 5-min break
interval=0;
lastpoint=1;
r = 6400;
for k = 1:len
    datetime{k} = [date{k},' ',time{k}];   
end
    
for i = 1:len
    
    dis = (pi*distance(lat(i),lon(i),lat(a(j,lastpoint)),lon(a(j,lastpoint)))*r)/180;
    breakinterval = (datenum(datetime{i})-datenum(datetime{max(i-1,1)}))*dateToTimeRatio;
    if dis >=1 &&  breakinterval < breaklimit
        lastpoint=lastpoint+1;
        a(j,lastpoint) = i;
    else
        interval = (datenum(datetime{i})-datenum(datetime{a(j,lastpoint)}))*dateToTimeRatio;
        if interval >= timeLimit || breakinterval >= breaklimit
            if lastpoint == 1
               a(j,lastpoint)=i;
               continue;
            end
            lastpoint = 1;
            j=j+1;
            a(j,lastpoint)=i;  
            
        end
    end
    

end
     try
        findFrequent(a,lat,lon,fileNames{userfile});
     catch exception
         fileout='out1.txt';
         fid=fopen(fileout,'at+');                     
         fprintf(fid,'\n error');   
         fclose(fid); 
         disp('finish a error');
         continue;
     end
end

