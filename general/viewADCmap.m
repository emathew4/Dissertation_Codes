function []=viewADCmap(ADC)
ADC=squeeze(ADC);

%% Remove Infinite vaues
ADC(ADC==Inf)=NaN;
ADC(ADC==-Inf)=NaN;
%% Normalize ADC
normADC=rescale(ADC);

%% View
figure

if size(normADC,3)>1
    montage(normADC);
else
    imshow(normADC);
end