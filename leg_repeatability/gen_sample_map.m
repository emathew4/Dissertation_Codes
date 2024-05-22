
cd '/Volumes/My Passport for Mac/Repeatability_Analysis/HC_0028_Analysis'

%fit1=load('registration/analysis/first_out/fitted_params.mat');
fit2=load('registration/analysis/second_out/fitted_params.mat');

rep_slice=25;

roughmask=single(fit2.fa(:,:,rep_slice)>.1)+single(fit2.fa(:,:,rep_slice)<.5);

pars=fieldnames(fit2);

for i=1:length(pars)
    currpar=fit2.(pars{i});
    %40:280 for both legs
    currslice=currpar(40:160,110:230,rep_slice);
    if i>3 && i<7
        viewADCmap(rot90(currslice),[0,2.4e-3])
    else
        viewADCmap(rot90(currslice),[0,1])
    end
end

%colorbar_white_background(0,1);
%colorbar_white_background(0,2.4e-3);
