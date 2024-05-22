function philips_dcm2nii_mfa(sortedDir)
% use something similar to the following lines to make sortedDir
% d=dir('mfa*');
% sortedDir=natsortfiles(d);

for i=1:length(sortedDir)
    philips_dcm2nii(sortedDir(i).name);
    niftiname=[sortedDir(i).name,'.nii'];
    
    if i==1
        comb_t1=niftiread(niftiname);
    else
        comb_t1=cat(4,comb_t1,niftiread(niftiname));
    end
    delete(niftiname);
end

niftiwrite(comb_t1,'mfa.nii');