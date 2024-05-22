function ba_stats = plot_all_bland_altmans(valout,display)
% uses BlandAltman.m from Ran Klein https://www.mathworks.com/matlabcentral/fileexchange/45049-bland-altman-and-correlation-plot
if nargin<2
    display=0;
end

f1=fieldnames(valout);
f2=fieldnames(valout.(f1{1}));

for i=1:length(f1)
    for j=1:length(f2)
        dat={valout.(f1{i}).(f2{j})}';
        for k=length(dat):-1:1
            if sum(isnan(dat{k}))>0
                dat(k)=[];
            end
        end
        dat=cell2mat(dat);
        if contains(f1{i},'d')
            dat=dat*1000;   % convert Diffusivity metrics from mm2/s to um2/ms
        end

        [~,~,stats]=BlandAltman(dat(:,1),dat(:,2),{'Test','Retest',[f1{i},' in ',f2{j}]});
        if display==0
            close;
        end
        ba_stats{i,j}=stats;
    end
end
% dat=cell2mat({valout.md.ta}');   % choose whichever parameter/ROI for plotting
% BlandAltman(dat(:,1),dat(:,2))
% figure;
% g=gca;
% params=PlotBA(g,data,stats,params);