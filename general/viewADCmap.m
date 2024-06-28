function []=viewADCmap(ADC,disp_range)
% disp_range should be 1x2 [lowerlim, upperlim] 
if islogical(ADC)
    ADC=double(ADC);
end
ADC=squeeze(ADC);
if nargin<2 
    disp_range = [min(ADC(:)),max(ADC(:))]; % if no disp_range given, show mat2gray of data
    if disp_range(1)==disp_range(2)
        disp_range(2)=disp_range(2)+eps;
        disp('Data seems to be completely homogenous')
    end
end
% %% Remove Infinite vaues
% ADC(ADC==Inf)=NaN;
% ADC(ADC==-Inf)=NaN;
% %% Normalize ADC
% normADC=rescale(ADC);
%% View
figure

if size(ADC,3)>1
    montage(ADC,'DisplayRange',disp_range);
else
    imshow(ADC,'DisplayRange',disp_range);
end