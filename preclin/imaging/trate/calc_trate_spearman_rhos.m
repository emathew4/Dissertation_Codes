function [spear_rhos,spear_pvals,hist_avgs,trate_results] = calc_trate_spearman_rhos(trate,hist)

histpars=fieldnames(hist.als70f);
histpars = histpars([1,2,3,5]); % excluding emhyc for now (since shouldn't correlate directly with any)

% Need to remove animal #s 255, 271, 272, 275 (since no TRATE data for
% those to compare to)
hist.wt70m=remove_animal_hist(hist.wt70m,1); % 255
hist.als110f=remove_animal_hist(hist.als110f,[2,3]); % 271, 272
hist.als110m=remove_animal_hist(hist.als110m,1); % 275


hist_wtcell={hist.wt70m,hist.wt70f,hist.wt110m,hist.wt110f,hist.wt150m,hist.wt150f,hist.wt170m,hist.wt170f};
hist_alscell={hist.als70m,hist.als70f,hist.als110m,hist.als110f,hist.als150m,hist.als150f,hist.als170m,hist.als170f};
hist_cells=horzcat(hist_wtcell,hist_alscell);

trate_wtcell={trate.wt70m,trate.wt70f,trate.wt110m,trate.wt110f,trate.wt150m,trate.wt150f,trate.wt170m,trate.wt170f};
trate_alscell={trate.als70m,trate.als70f,trate.als110m,trate.als110f,trate.als150m,trate.als150f,trate.als170m,trate.als170f};
trate_cells=horzcat(trate_wtcell,trate_alscell);

trate_wtcell=[trate.wt70m;trate.wt70f;trate.wt110m;trate.wt110f;trate.wt150m;trate.wt150f;trate.wt170m;trate.wt170f];
trate_alscell=[trate.als70m;trate.als70f;trate.als110m;trate.als110f;trate.als150m;trate.als150f;trate.als170m;trate.als170f];
trate_results=[trate_wtcell;trate_alscell];



num_cats=length(hist_cells);
num_subjs_per_group=5; % 5 because 5 animals per group

hist_avgs=zeros(size(trate_results,1),length(histpars));
for i=1:length(histpars)
    currind=1;

    for j=1:num_cats
        if strcmp('emhyc',histpars{i}) || strcmp('density',histpars{i})
            hist_avgs(currind:currind-1+size(hist_cells{j}.density,2),i)=hist_cells{j}.(histpars{i});
            currind=currind+size(hist_cells{j}.density,2);
        else
            hist_avgs(currind:currind-1+size(hist_cells{j}.density,2),i)=mean(hist_cells{j}.(histpars{i}),'omitnan');
            currind=currind+size(hist_cells{j}.density,2);
        end
    end
end

spear_rhos=zeros(1,length(histpars));
spear_pvals=zeros(1,length(histpars));

for i=1:length(histpars)
    [rho,pval]=corr(trate_results,hist_avgs(:,i),'Type','Spearman','Rows','all');
    spear_rhos(i)=rho;
    spear_pvals(i)=pval;
end


spear_rhos=array2table(spear_rhos,'VariableNames',histpars);
spear_pvals=array2table(spear_pvals,'VariableNames',histpars);

end

function hist_group=remove_animal_hist(hist_group,inds_to_remove) % 1-5 for which animal(s) # from that group to remove
pars=fieldnames(hist_group);

for k=1:length(pars)
    if strcmp('emhyc',pars{k}) || strcmp('density',pars{k})
        hist_group.(pars{k})(inds_to_remove)=[];
    else
        hist_group.(pars{k})(:,inds_to_remove)=[];
    end
end
end