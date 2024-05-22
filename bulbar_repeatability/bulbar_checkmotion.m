function [motion_vols,ssims] = bulbar_checkmotion(diff_data,bvals)
%%
%% NOTE: STILL REQUIRES BVAL THRESHOLDS (NEAR BOTTOM) HARDCODED; CHANGE AS NEEDED
% diff_data should be 4D, with slices in 3rd dimension and
% diffusion volumes in 4th dimension, and b0 as first volume
% (or whatever reference image you want to use as first volume)

% bvals should be same length as # of diffusion volumes, e.g. if
% 3 directions and 2 b-values + 1 b0, bvals = [0 400 400 400 700 700 700]


% to read bvals from bval.bval, do the following
% fid=fopen('bval.bval','r');
% formspec='%i';
% bvals=fscanf(fid,formspec);
% fclose(fid);
%%
diff_size=size(diff_data);

if sum(size(bvals)==union(diff_size(4),1))~=2
    error('bvals should have bval for each diffusion volume listed sequentially')
end

ssims=zeros(diff_size(3),diff_size(4));
ssims(:,1)=1;

% Philips does all diffusion acquisition for one slice before moving to
% next slice, so motion-correction/detection will be slice dependent. If
% data is acquired on a diffusion direction basis instead (i.e. all slices
% for one direction, then all slices for next direction, etc.) then could
% do 3D SSIM instead by removing loop with i and changing i to : in
% indexing

for i=1:diff_size(3)
    if min(diff_data(:,:,i,:),[],'all')==max(diff_data(:,:,i,:),[],'all')
        ssims(i,:)=0;
        continue
    end
    for j=2:diff_size(4)
        ssims(i,j)=ssim(diff_data(:,:,i,j),diff_data(:,:,i,1),'DynamicRange',range(reshape(diff_data(:,:,i,1),[],1)));
    end
end

%motion_vols=ssims<.75; % could maybe do 0.8 for stricter check

% since b-value affects SSIM, could also do motion check based on average
% SSIM for that b-value; would need to pass b-vals as argument then

b600thresh=.7;
b1200thresh=.6;
b1800thresh=.5;

thresholds=bvals;
thresholds(thresholds==600)=b600thresh;
thresholds(thresholds==1200)=b1200thresh;
thresholds(thresholds==1800)=b1800thresh;

motion_vols=ssims<thresholds;

end