function [a,tbl,stats] = trate_anova()

trate=load('/Users/ethanmathew/Desktop/ALS_Preclin_2022/TRATE_Results/trate_analysis.mat');

trate_wtcell=[trate.wt70m;trate.wt70f;trate.wt110m;trate.wt110f;trate.wt150m;trate.wt150f;trate.wt170m;trate.wt170f];
trate_alscell=[trate.als70m;trate.als70f;trate.als110m;trate.als110f;trate.als150m;trate.als150f;trate.als170m;trate.als170f];
trate_results=[trate_wtcell;trate_alscell];

distype=[zeros(1,length(trate_wtcell)),ones(1,length(trate_alscell))];
gender=[zeros(size(trate.wt70m));ones(size(trate.wt70f));zeros(size(trate.wt110m));ones(size(trate.wt110f));zeros(size(trate.wt150m));ones(size(trate.wt150f));zeros(size(trate.wt170m));ones(size(trate.wt170f));zeros(size(trate.als70m));ones(size(trate.als70f));zeros(size(trate.als110m));ones(size(trate.als110f));zeros(size(trate.als150m));ones(size(trate.als150f));zeros(size(trate.als170m));ones(size(trate.als170f))]';
timepoint=[zeros(size(trate.wt70m));zeros(size(trate.wt70f));ones(size(trate.wt110m));ones(size(trate.wt110f));2*ones(size(trate.wt150m));2*ones(size(trate.wt150f));3*ones(size(trate.wt170m));3*ones(size(trate.wt170f));zeros(size(trate.als70m));zeros(size(trate.als70f));ones(size(trate.als110m));ones(size(trate.als110f));2*ones(size(trate.als150m));2*ones(size(trate.als150f));3*ones(size(trate.als170m));3*ones(size(trate.als170f))]';

[p,tbl,stats]=anovan(trate_results,{distype gender timepoint},'model',3,'varnames',{'Disease Status','Gender','Time'},'display','off');

a(:,1)=tbl(:,1);
a(:,2)=tbl(:,7);
a(1,2)={'TRATE p-values'};
a(9:10,:)=[];
% use multcompare for post-hoc tests