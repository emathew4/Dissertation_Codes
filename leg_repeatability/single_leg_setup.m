b01=niftiread('first_scan/b0ap1.nii');
fullb01=niftiread('first_scan/full_b0_combined.nii');
proc1=niftiread('first_scan/processed_data/processed_data.nii.gz');

niftiwrite(b01(:,1:160,:),'first_scan/processed_data/single_leg_data/left/b01_left.nii');
niftiwrite(fullb01(:,1:160,:,:),'first_scan/processed_data/single_leg_data/left/fullb0_left.nii');
niftiwrite(proc1(:,1:160,:,:),'first_scan/processed_data/single_leg_data/left/proc1_left.nii');

niftiwrite(b01(:,161:end,:),'first_scan/processed_data/single_leg_data/right/b01_right.nii');
niftiwrite(fullb01(:,161:end,:,:),'first_scan/processed_data/single_leg_data/right/fullb0_right.nii');
niftiwrite(proc1(:,161:end,:,:),'first_scan/processed_data/single_leg_data/right/proc1_right.nii');

b02=niftiread('second_scan/b0ap2.nii');
fullb02=niftiread('second_scan/full_b0_combined.nii');
proc2=niftiread('second_scan/processed_data/processed_data.nii.gz');

niftiwrite(b02(:,1:160,:),'second_scan/processed_data/single_leg_data/left/b02_left.nii');
niftiwrite(fullb02(:,1:160,:,:),'second_scan/processed_data/single_leg_data/left/fullb0_left.nii');
niftiwrite(proc2(:,1:160,:,:),'second_scan/processed_data/single_leg_data/left/proc2_left.nii');

niftiwrite(b02(:,161:end,:),'second_scan/processed_data/single_leg_data/right/b02_right.nii');
niftiwrite(fullb02(:,161:end,:,:),'second_scan/processed_data/single_leg_data/right/fullb0_right.nii');
niftiwrite(proc2(:,161:end,:,:),'second_scan/processed_data/single_leg_data/right/proc2_right.nii');

