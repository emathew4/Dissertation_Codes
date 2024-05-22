function [R1,conc] = t1_gesf_conc_calc(t1map,gesf_dir)

%[m0map,t1map]=t1_vtr_calc(vtr_dir);

cd(gesf_dir)
d=dir('*.nii');

gesf=niftiread(d.name);
s1=squeeze(gesf(:,:,1,:,:));
pars=readnmrpar('method');

[conc,R1]=Conc(imresize3(t1map(:,:,2:2:end),[64,64,8],'Method','linear'),s1,pars);