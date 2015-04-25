function [usersUTM]=utmprojection(users)
axesm utm
Z='50S';
setm(gca,'zone',Z);
h = getm(gca);
usersUTM=cell(length(users),1);
for i=1:length(users)    
    disp(i);
    eachUserRoute = users{i,1};
    for j=1:size(eachUserRoute,1)
        L = [eachUserRoute{j,1}{1,1},eachUserRoute{j,1}{2,1}];
        R=zeros(size(L));
        for k=1:size(L,1)
            [x,y]= mfwdtran(h,L(k,1),L(k,2));
            R(k,:)=[x;y];
        end
        usersUTM{i,1}{j,1}=R;
    end
end

