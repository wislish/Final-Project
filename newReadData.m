fileFolder=fullfile('H:\大学学习\大四上\Projects\code\Geolife Trajectories 1.3\Geolife Trajectories 1.3\Data');
dirOutput=dir(fullfile(fileFolder,'*'));
fileNames={dirOutput.name};
fileNames(:,[1,2])=[];

users = cell(92,1);
num=0;
for userfile = 1:length(fileNames)
    
    user = cell(3,1);
    lat=[];
    lon =[];
    date=[];
    time=[];
    datetime=[];
    capacity=0;
    file = dir(['H:\大学学习\大四上\Projects\code\Geolife Trajectories 1.3\Geolife Trajectories 1.3\Data\',fileNames{userfile},'\Trajectory\*.plt']);
    %     disp([fileNames{userfile},' ',file(length(file)).name ]);
    %     if ismember(1,strfind(file(length(file)).name,'2013'))
    %         num=num+1;
    %     end
    %     disp(num);
    
    for n = 1:length(file)
        capacity=capacity + file(n).bytes;
    end
    
    if capacity > 5000000 || capacity < 500000
        continue;
    end
    num=num+1;
    
    for n = 1:length(file)
        [blat blon bc3 balt bdateInDays bdate btime] = textread(['H:\大学学习\大四上\Projects\code\Geolife Trajectories 1.3\Geolife Trajectories 1.3\Data\',fileNames{userfile},'\Trajectory\',file(n).name],'%f %f %d %s %f %s %s','delimiter',',','headerlines',6);
        lat = [lat;blat];
        lon = [lon;blon];
        date = [date;bdate];
        time = [time;btime];
    end
    len = length(lat);
    for k = 1:len
        datetime{k} = [date{k},' ',time{k}];
    end
    user{1,1}=lat;
    user{2,1}=lon;
    user{3,1}=datetime;
    users{num,1}=user;
end