function [p,pairs,positions] = wt_als_cov_boxplots(wtcell,alscell,category,categorynames,colors,legendnames)
% For all data: wt_als_cov_boxplots({wt70m,wt70f,wt110m,wt110f,wt150m,wt150f,wt170m,wt170f},{als70m,als70f,als110m,als110f,als150m,als150f,als170m,als170f},[1,1,2,2,3,3,4,4,1,1,2,2,3,3,4,4],{'Day70','Day110','Day150','Day170'},[col;col;col;col]',{'WT Male','WT Female','ALS Male','ALS Female'});
% For single sex: wt_als_cov_boxplots({wt70m,wt110m,wt150m,wt170m},{als70m,als110m,als150m,als170m},[1,2,3,4,1,2,3,4],{'Day70','Day110','Day150','Day170'},[col;col]',{'WT Male','ALS Male'});
%                 wt_als_cov_boxplots({wt70f,wt110f,wt150f,wt170f},{als70f,als110f,als150f,als170f},[1,2,3,4,1,2,3,4],{'Day70','Day110','Day150','Day170'},[col;col]',{'WT Female','ALS Female'});

% For RGB colors, if c1=[0 0.4470 0.7410]; and c2=[0.9290 0.6940 0.1250];
% then e.g. colors = [c1;c2;c1;c2]';

% category should be in order of wtcells_categories, alscells_categories
% e.g. if 2 WT timepoints and 2 ALS timepoints then category = [1,2,1,2]
% and categorynames = {'Day70','Day110'}

% categorynames should contain name for each category in order
% length(categorynames) == length(unique(category))

% colors should contain color for each group using matlab single letter
% color names, i.e. colors = ['r','c','r','y'] for 4 groups would plot 1st
% and 3rd group in same color
% or can contain RGB triplets if colors is 3xn where n is number of groups
% and each column corresponds to RGB for that group
%
% legendnames should be legend for what each color represents in order
% of first appearance of color
% i.e. for above example, legendnames={'red,'cyan','yellow'}
% length(legendnames) == length(unique(colors))

arguments
    wtcell cell
    alscell cell
    category
    categorynames = unique(category);
    colors = []
    legendnames = []

end
bothcells=horzcat(wtcell,alscell);
[u,~,ic]=unique(category);

x=[];
g=[];
currnum=1;
for i=1:length(u)
    currcat=bothcells(ic==i);
    for j=1:length(currcat)
        x=[x;currcat{j}];
        g=[g;currnum*ones(size(currcat{j}))];
        currnum=currnum+1;
    end
end

%% This section performs statistical analysis
[p,~,stats]=anova1(x,g,'off');
pairs=[];
if p<.05
    c=multcompare(stats,'Display','off');
    pairs=c(squeeze(c(:,6))<.05,1:2);
end

%% Violin plots
positions = grouped_boxplots(x,g,sort(category),categorynames,colors,legendnames);
title('Coefficient of Variation');


