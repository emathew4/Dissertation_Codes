function bulbar_data_conv(b0pe_dcm,b0rpe_dcm,diff_dcm,dce_dcm,gre_dcm,se_dcm) %mfa_dir

% Convert non-diffusion data to dcm
philips_dcm2nii_dce(dce_dcm);
philips_dcm2nii_dce(gre_dcm);
philips_dcm2nii_se(se_dcm);
%philips_dcm2nii_mfa(mfa_dir);

% Handle diffusion data, create bval and bvec files
bulbar_processing_topup(b0pe_dcm,b0rpe_dcm,diff_dcm);