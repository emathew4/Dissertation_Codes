function vals = get_dki_tongue_vals()

try
    dkimask=niftiread('masks/dti_tongue.nii.gz');
catch
    dkimask=niftiread('masks/dti_tongue.nii');
end

dkifit=load('dki_out/dipyout/dkiparameters.mat');
dtifit=load('dki_out/dipyout/dtiparameters.mat');
%dkifit=load('raw_diff_fitting/dkiparameters.mat');
%dtifit=load('raw_diff_fitting/dtiparameters.mat');
md=nonzeros(dtifit.dti_md.*dkimask);
ad=nonzeros(dtifit.dti_ad.*dkimask);
rd=nonzeros(dtifit.dti_rd.*dkimask);
fa=nonzeros(dtifit.dti_fa.*dkimask);
fa(fa>0.5 | fa<0.01)=[];
md=remove_outlier_diffusivity(md);
ad=remove_outlier_diffusivity(ad);
rd=remove_outlier_diffusivity(rd);

mk=nonzeros(dkifit.mk.*dkimask);
ak=nonzeros(dkifit.ak.*dkimask);
rk=nonzeros(dkifit.rk.*dkimask);
mk=remove_outlier_kurtosis(mk);
ak=remove_outlier_kurtosis(ak);
rk=remove_outlier_kurtosis(rk);

vals.md=mean(md);
vals.ad=mean(ad);
vals.rd=mean(rd);
vals.fa=mean(fa);
vals.mk=mean(mk);
vals.ak=mean(ak);
vals.rk=mean(rk);

end

function diff_vals=remove_outlier_diffusivity(diff_vals)
    diff_vals(diff_vals>2.5e-3|diff_vals<9.5e-4)=[];
end

function kurt_vals=remove_outlier_kurtosis(kurt_vals)
    kurt_vals(kurt_vals>2|kurt_vals<.01)=[];
end