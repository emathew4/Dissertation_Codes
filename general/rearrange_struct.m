function structout = rearrange_struct(structin,reverseflag)

if nargin==1
    reverseflag=false;
end

f1=fieldnames(structin);
f2=fieldnames(structin.(f1{1}));

structout=struct;

for i=1:length(f2)
    for j=1:length(f1)
        if reverseflag
            structout.(f2{i}).(f1{j})=reshape([structin.(f1{j}).(f2{i})],[],2);
        else
        structout.(f2{i}).(f1{j})=reshape([structin.(f1{j}).(f2{i})],2,[])';
        end
    end
end
end