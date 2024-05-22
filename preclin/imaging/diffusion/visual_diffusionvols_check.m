function visual_diffusionvols_check()
maindir='/Users/ethanmathew/Desktop/ALS_Preclin_2022/Data';

cd(maindir);
d=dir('EM*');

for i=1:length(d)
    cd(d(i).name);
    find_diffusion_folder;
    proc=niftiread('dkitoflash.nii');
    
    for j=1:size(proc,4)
        viewADCmap(proc(:,:,:,j))
    end
    cd(maindir)
end     % keep breakpoint to view images for each animal; otherwise will get them all at once
    
end