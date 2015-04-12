
    
    lat=[];
    lon =[];
    date=[];
    time=[];
    file = dir(['H:\大学学习\大四上\Projects\code\Geolife Trajectories 1.3\Geolife Trajectories 1.3\Data\047\Trajectory\*.plt']);
    
    for n = 1:length(file)
        disp(n);
        [blat blon bc3 balt bdateInDays bdate btime] = textread(['H:\大学学习\大四上\Projects\code\Geolife Trajectories 1.3\Geolife Trajectories 1.3\Data\047\Trajectory\',file(n).name],'%f %f %d %s %f %s %s','delimiter',',','headerlines',6);
    end
