function [] = bulbar_processing_topup(b0pe_dcm,b0rpe_dcm,diff_dcm)
% numBVal=4;  % Change to your number of b-values

%% Setup: Convert dicoms
b0s_combined_name='full_b0_combined.nii';
dki_b0_combined_name=[diff_dcm '_withb0.nii'];

philips_dcm2nii(b0pe_dcm,1);    % b0 AP
philips_dcm2nii(b0rpe_dcm,1);    % b0 PA

[dcmhdr,totalDirs] = philips_dcm2nii(diff_dcm);    % complete dki
% numDirs=totalDirs/numBVal;

b0pe_nii=[b0pe_dcm '.nii'];
b0rpe_nii=[b0rpe_dcm '.nii'];
dki_nii=[diff_dcm '.nii'];

b0pe=niftiread(b0pe_nii);   % read b0pe in data from nii
b0rpe=niftiread(b0rpe_nii); % read b0rpe in data from nii
dki=niftiread(dki_nii);     % read dki data in

pe_info = niftiinfo(b0pe_nii);

dki_info=niftiinfo(dki_nii);
dkivox=dki_info.PixelDimensions(1:2);   % Assumes slice coverage is the same
pevox=pe_info.PixelDimensions(1:2);


%% Create .bval and .bvec
outfold='dki_out';
mkdir(outfold);
philips_diffinfo_creator(dcmhdr,totalDirs,outfold);
%philips_diffinfo_creator(dcmhdr,totalDirs);
%% Create B0s nii for topup and combined B0/DKI for Eddy
dki_philips_b0combiner(b0pe,b0rpe,pe_info,b0s_combined_name); % combine b0s for topup

if ~isequal(dkivox,pevox)
    b0size=size(b0pe);
    b0pe=imresize3(b0pe,[b0size(1)*pevox(1)/dkivox(1) b0size(2)*pevox(2)/dkivox(2) b0size(3)]);
%     niftiwrite(b0pe,'resb0.nii');
%     info=niftiinfo('resb0.nii');
%     info.PixelDimensions(1:3)=dki_info.PixelDimensions(1:3);
%     niftiwrite(b0pe,'resb0.nii',info);
end
dki_philips_b0combiner(b0pe,dki,dki_info,dki_b0_combined_name);



%% Create index.txt file for Eddy
indextxt=ones(totalDirs+1,1);
dlmwrite('index.txt',indextxt,'delimiter',' ');
%% Topup Setup
acq='topup_acqparams.txt';
topout='topup_out_full';
fout='topupfmap_full';
iout='unwarpedb0_full';
topup=['/usr/local/fsl/bin/topup --imain=',b0s_combined_name,' --datain=',acq,' --config=b02b0.cnf --out=',topout,' --fout=',fout,' --iout=',iout];
curr=pwd;

command=['cd "',curr,'"; ',topup];    % topup terminal command

system(command) % run topup through terminal


end