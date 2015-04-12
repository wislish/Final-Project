fileFolder=fullfile('H:\大学学习\大四上\Projects\code\Geolife Trajectories 1.3\Geolife Trajectories 1.3\Data');
dirOutput=dir(fullfile(fileFolder,'*'));
fileNames={dirOutput.name};
fileNames(:,[1,2])=[];
num = 0;
 for userfile = 1:length(fileNames)
     
    capacity = 0;
    file = dir(['H:\大学学习\大四上\Projects\code\Geolife Trajectories 1.3\Geolife Trajectories 1.3\Data\',fileNames{userfile},'\Trajectory\*.plt']);
    
    for n = 1:length(file)
         capacity=capacity + file(n).bytes;
    end
    
    if capacity < 5000000 || capacity >11000000
         rmdir(['H:\大学学习\大四上\Projects\code\Geolife Trajectories 1.3\Geolife Trajectories 1.3\Data\',fileNames{userfile}],'s');
    end
    
    
 end