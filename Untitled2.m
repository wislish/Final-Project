 file = dir(['H:\��ѧѧϰ\������\Projects\code\Geolife Trajectories 1.3\Geolife Trajectories 1.3\Data\018\Trajectory\*.plt']);
    
    for n = 1:length(file)
        try
            [blat blon bc3 balt bdateInDays bdate btime] = textread(['H:\��ѧѧϰ\������\Projects\code\Geolife Trajectories 1.3\Geolife Trajectories 1.3\Data\018\Trajectory\',file(n).name],'%f %f %d %s %f %s %s','delimiter',',','headerlines',6);
    
        catch exception
            continue;
        end    
    end