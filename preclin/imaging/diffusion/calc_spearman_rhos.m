function [spear_rhos,spear_pvals,hist_avgs,mr_avgs] = calc_spearman_rhos(mr,hist)

histpars=fieldnames(hist.als70f);
histpars = histpars([1,2,3,5]); % excluding emhyc for now (since shouldn't correlate directly with any)

mrpars=fieldnames(mr.als70f.pars);
mrpars = mrpars([1:3,5,7:8]); % remove primdir, eval1, and evecs

hist_wtcell={hist.wt70m,hist.wt70f,hist.wt110m,hist.wt110f,hist.wt150m,hist.wt150f,hist.wt170m,hist.wt170f};
hist_alscell={hist.als70m,hist.als70f,hist.als110m,hist.als110f,hist.als150m,hist.als150f,hist.als170m,hist.als170f};
hist_cells=horzcat(hist_wtcell,hist_alscell);

mr_wtcell={mr.wt70m,mr.wt70f,mr.wt110m,mr.wt110f,mr.wt150m,mr.wt150f,mr.wt170m,mr.wt170f};
mr_alscell={mr.als70m,mr.als70f,mr.als110m,mr.als110f,mr.als150m,mr.als150f,mr.als170m,mr.als170f};
mr_cells=horzcat(mr_wtcell,mr_alscell);

num_cats=length(mr_cells);
num_subjs_per_group=5; % 5 because 5 animals per group

hist_avgs=zeros(num_cats*num_subjs_per_group,length(histpars)); 
for i=1:length(histpars)
    for j=1:num_cats
            if strcmp('emhyc',histpars{i}) || strcmp('density',histpars{i})                        
            hist_avgs((j-1)*num_subjs_per_group+1:(j-1)*num_subjs_per_group+5,i)=hist_cells{j}.(histpars{i});            
            else         
            hist_avgs((j-1)*num_subjs_per_group+1:(j-1)*num_subjs_per_group+5,i)=mean(hist_cells{j}.(histpars{i}),'omitnan');
            end
    end
end

mr_avgs=zeros(num_cats*num_subjs_per_group,length(mrpars)); 
for i=1:length(mrpars)
    for j=1:num_cats
        mr_avgs((j-1)*num_subjs_per_group+1:(j-1)*num_subjs_per_group+5,i)=mr_cells{j}.overall_avgs.(mrpars{i});
    end
end

spear_rhos=zeros(length(mrpars),length(histpars));
spear_pvals=zeros(length(mrpars),length(histpars));
for i=1:length(mrpars)
    for j=1:length(histpars)
        [rho,pval]=corr(mr_avgs(:,i),hist_avgs(:,j),'Type','Spearman','Rows','all');
        spear_rhos(i,j)=rho;
        spear_pvals(i,j)=pval;
    end
end

spear_rhos=array2table(spear_rhos','VariableNames',mrpars);
spear_pvals=array2table(spear_pvals','VariableNames',mrpars);