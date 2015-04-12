fileFolder=fullfile('I:\大学学习\大四上\Projects\code\Geolife Trajectories 1.3\Geolife Trajectories 1.3\Data');
dirOutput=dir(fullfile(fileFolder,'*'));
fileNames={dirOutput.name};
fileNames(:,[1,2])=[];

 for userfile = 1:length(fileNames)
     
    lat=[];
    lon =[];
    date=[];
    time=[];
    file = dir(['I:\大学学习\大四上\Projects\code\Geolife Trajectories 1.3\Geolife Trajectories 1.3\Data\',fileNames{userfile},'\Trajectory\*.plt']);
    
    for n = 1:length(file)
    
    [blat blon bc3 balt bdateInDays bdate btime] = textread(['I:\大学学习\大四上\Projects\code\Geolife Trajectories 1.3\Geolife Trajectories 1.3\Data\',fileNames{userfile},'\Trajectory\',file(n).name],'%f %f %d %d %f %s %s','delimiter',',','headerlines',6);
    lat = [lat;blat];
    lon = [lon;blon];
    date = [date;bdate];
    time = [time;btime];
    end
    
end

