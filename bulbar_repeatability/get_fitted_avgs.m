function [se_t2mean,gre_t2smean,dce_t2smean] = get_fitted_avgs
sefit=load('fitted_maps/SE_Fitting.mat');
grefit=load('fitted_maps/GRE_Fitting.mat');
dcefit=load('fitted_maps/DCE_Fitting.mat');

semask=niftiread('masks/se_tongue.nii.gz');
gremask=niftiread('masks/gre_tongue.nii.gz');
dcemask=niftiread('masks/dce_tongue.nii.gz');

se_t2masked=nonzeros(sefit.T2.*semask);
se_t2masked(se_t2masked>100|se_t2masked<0)=[];
gre_t2smasked=nonzeros(grefit.T2s.*gremask);
gre_t2smasked(gre_t2smasked>100|gre_t2smasked<0)=[];
dce_t2smasked=nonzeros(dcefit.T2s.*dcemask);
dce_t2smasked(dce_t2smasked>100|dce_t2smasked<0)=[];

se_t2mean=mean(rmoutliers(se_t2masked));
gre_t2smean=mean(rmoutliers(gre_t2smasked));
dce_t2smean=mean(rmoutliers(dce_t2smasked));