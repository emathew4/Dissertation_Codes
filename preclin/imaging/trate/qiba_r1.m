function [R1,conc]=qiba_r1(t1map,gesf_dir)

cd(gesf_dir)
d=dir('*.nii');

gesf=niftiread(d.name);
s1=squeeze(gesf(:,:,1,:,:));
pars=readnmrpar('method');

tr=pars.PVM_RepetitionTime/1000;
flipangle=str2double(pars.ExcPulse(11:12));
r1 = 3.2;% CA relaxivity in mmol/s
s0=mean(s1(:,:,:,1:5),4);

res_t1=imresize3(t1map(:,:,2:2:end),[64,64,8],'Method','linear');

E10=exp(-tr/res_t1);
B=(1-E10)./(1-cosd(flipangle).*E10);
A=B.*s1./s0;

R1=-log((1-A)./(1-cosd(flipangle).*A))/tr;

conc=(R1-1/res_t1)/r1; 