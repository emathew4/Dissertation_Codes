function vals = wt_als_violins()
%%             WT M        WT F       ALS M       ALS F
% Day 70     265-269     260-264     255-259     250-254
% Day 110    295-299     290-294     275-279     270-274
% Day 150    305-309     300-304     285-289     280-284
% Day 170    315-319     320-324     325-329     310-314
%%
maindir='/Users/ethanmathew/Desktop/ALS_Preclin_2022/Data';
cd(maindir);
d=dir('EM*R03*');
% Set breakpoint below to manually adjust d if needed to exclude folders

for i=length(d):-1:1
    cd(d(i).name);
    mask=niftiread('mg.nii');
    find_diffusion_folder;
    cd output
    pars(i)=load('dtiparameters.mat');

    mask=imresize3(mask(:,:,2:2:end),[64,64,8],'Method','nearest');
    vals(i)=extract_vals(pars(i),mask);
    cd(maindir);
end

s=fieldnames(vals);
num = length(vals);
for fnames=3%[1:3,5,7:8]%1:length(s)

    x=cell2mat({vals(:).(s{fnames})}');
    g=[];
    for j=1:num
        g=[g;j*ones(size(vals(j).(s{fnames})))];
    end
    figure;vs=violinplot(x,g,'Showdata',false);
end

% ST = dbstack;
% if length(ST) < 1; return; end
% dbstop('in', ST(1).file, 'at', num2str(ST(1).line+1)); % This is here to make sure you want to print all these figures; comment out above and below if not
% 
% parname='';
% switch fnames
%     case 1
%         parname='Axial Diffusivity';
%         title('Axial Diffusivity')
%         ylabel('Axial Diffusivity (mm^2/s)')
%     case 2
%         parname='Fractional Anisotropy';
%         title('Fractional Anisotropy')
%         ylabel('Fractional Anisotropy')
%     case 3
%         parname='Mean Diffusivity';
%         title('Mean Diffusivity')
%         ylabel('Mean Diffusivity (mm^2/s)')
%     case 5
%         parname='Radial Diffusivity';
%         title('Radial Diffusivity')
%         ylabel('Radial Diffusivity (mm^2/s)')
%     case 7
%         parname='L2';
%         title('\lambda_2')
%         ylabel('\lambda_2 (mm^2/s)')
%     case 8
%         parname='L3';
%         title('\lambda_3')
%         ylabel('\lambda_3 (mm^2/s)')
%     otherwise
%         disp(['no switch case for parameter ', fnames,' found'])
% end
% 
% 
% switch j
%     case 1
%         savename='WTM';
%     case 2
%         savename='WTF';
%     case 3
%         savename='ALSM';
%     case 4
%         savename='ALSF';
% end
% savename=[parname,'_',savename,'_',categorynames{i},'.tif'];
% print(gcf,'-dtiff',savename);
% close;