function [lvals,rvals,lstds,rstds]=extract_all_vals_masked
%function [vals,stds]=extract_all_vals_masked

fit1=load('registration/analysis/first_out/fitted_params.mat');
fit2=load('registration/analysis/second_out/fitted_params.mat');

%maskdir='registration/masks/t2masks/combined/';
maskdir='registration/masks/t2masks/';
masks=dir([maskdir '*.nii']);

[lvals,lstds]=get_struct(masks(1:end/2),maskdir,fit1,fit2);
[rvals,rstds]=get_struct(masks(end/2+1:end),maskdir,fit1,fit2);
%[vals,stds]=get_struct(masks,maskdir,fit1,fit2);
end

function [vals,stds] = get_struct(masks,maskdir,fit1,fit2)
for i=1:length(masks)
    segname=masks(i).name(2:end-4); 
    %segname=masks(i).name(1:end-4); 
    mask=niftiread(fullfile(maskdir,masks(i).name));

    extract1=extract_vals(fit1,mask);
    extract2=extract_vals(fit2,mask);

    vals1.(segname)=structfun(@mean,extract1,'UniformOutput',0);
    vals2.(segname)=structfun(@mean,extract2,'UniformOutput',0);

    stds1.(segname)=structfun(@std,extract1,'UniformOutput',0);
    stds2.(segname)=structfun(@std,extract2,'UniformOutput',0);
end

vals=rearrange_struct(mergestructs(vals1,vals2));
stds=rearrange_struct(mergestructs(stds1,stds2));
end

function struct1 = mergestructs(struct1, struct2)
% Since structs have same fieldnames/sizes, no data checking
fields=fieldnames(struct1);
for i=1:length(fields)
    curr_field=fields{i};
    struct1.(curr_field)=[struct1.(curr_field), struct2.(curr_field)];
end
end

function structout = rearrange_struct(structin)

f1=fieldnames(structin);
f2=fieldnames(structin.(f1{1}));

structout=struct;

for i=1:length(f2)
    for j=1:length(f1)
        structout.(f2{i}).(f1{j})=reshape([structin.(f1{j}).(f2{i})],2,[])';
    end
end
end