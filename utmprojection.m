function [usersUTM]=utmprojection(users)
axesm utm
Z=utmzone(users{1,1}{1,1}(1),users{1,1}{2,1}(1));
setm(gca,'zone',Z)
h = getm(gca);
usersUTM=cell(length(users),1);
for i=1:length(users)
    
    user = users{i,1};
    L = [user{1,1},user{2,1}];
    R=zeros(size(L));
    for k=1:size(L,1)
        disp(k);
        [x,y]= mfwdtran(h,L(k,1),L(k,2));
        R(k,:)=[x;y];
    end 
    usersUTM{i,1}=R;
end

