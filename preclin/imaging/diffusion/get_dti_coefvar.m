function cvs = get_dti_coefvar()

maindir='/Users/ethanmathew/Desktop/ALS_Preclin_2022/Data';
cd(maindir);
d=dir('EM*'); % set bp here to manually filter d as needed

names={d.name};
pat="R0";
a=extractAfter(names,pat);
[~,ndx,]=natsortfiles(a);

cov_pars={'dti_md','dti_ad','dti_rd','dti_fa','eval2','eval3'};
%i

for i=length(d):-1:1
cd(d(i).name);
mask=niftiread('mg.nii');
mask=imresize3(mask(:,:,2:2:end),[64,64,8],'Method','nearest');
find_diffusion_folder;
cd output

dti=load('dtiparameters.mat');
vals=extract_vals(dti,mask);
for j=1:length(cov_pars)
    cvs.(cov_pars{j})(i)=std(vals.(cov_pars{j}))/mean(vals.(cov_pars{j}));    
end

cd(maindir);
end

%cvs=cvs(ndx); % to get cvs ordered by animal #
for j=1:length(cov_pars)
    cvs.(cov_pars{j})=cvs.(cov_pars{j})(ndx); % to get cvs ordered by animal #
end