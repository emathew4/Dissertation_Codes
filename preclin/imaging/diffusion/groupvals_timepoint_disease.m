function [pars,masks,vals,overall_vals,overall_avgs] = groupvals_timepoint_disease()
%%             WT M        WT F       ALS M       ALS F
% Day 70     265-269     260-264     255-259     250-254
% Day 110    295-299     290-294     275-279     270-274
% Day 150    305-309     300-304     285-289     280-284
% Day 170    315-319     320-324     325-329     310-314
%%
maindir='/Users/ethanmathew/Desktop/ALS_Preclin_2022/Data';
cd(maindir);
d=dir('EM*R025*');
% Set breakpoint below to manually adjust d if needed to exclude folders 

for i=length(d):-1:1
cd(d(i).name);
mask=niftiread('mg.nii');
find_diffusion_folder;
cd output
pars(i)=load('dtiparameters.mat');
% proc=niftiread('dkitorun.nii');
% [~,mask]=bruker_auto_mask(proc);
% mask=bwareaopen(mask,1000);
mask=imresize3(mask(:,:,2:2:end),[64,64,8],'Method','nearest');
masks(:,:,:,i)=mask;
%vals(i)=extract_vals(pars(i),mask);
vals(i)=extract_vals(pars(i),mask);
avgs(i)=average_struct_vals(vals(i));
cd(maindir);
end

if length(d)>1
    overall_vals=combine_vals(vals(1),vals(2));
    overall_avgs=combine_vals(avgs(1),avgs(2));
end

for i=3:length(d)
    overall_vals=combine_vals(overall_vals,vals(i));
    overall_avgs=combine_vals(overall_avgs,avgs(i));
end

% save with appropriate name based on timepoint and disease status