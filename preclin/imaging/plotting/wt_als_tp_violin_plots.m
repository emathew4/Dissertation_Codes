function [pvals,significantpairs,positions] = wt_als_tp_violin_plots(wtcell,alscell,category,categorynames,colors,legendnames)
% wt_als_tp_boxplots({wt70,wt110,wt150,wt170},{als70,als110,als150,als170},[1,2,3,4,1,2,3,4],{'Day70','Day110','Day150','Day170'},['crcrcrcr'],{'WT','ALS'});
% wt_als_tp_boxplots({wt70m,wt70f,wt110m,wt110f,wt150m,wt150f,wt170m,wt170f},{als70m,als70f,als110m,als110f,als150m,als150f,als170m,als170f},[1,1,2,2,3,3,4,4,1,1,2,2,3,3,4,4],{'Day70','Day110','Day150','Day170'},['cgrbcgrbcgrbcgrb'],{'WT Male','WT Female','ALS Male','ALS Female'});

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
s=fieldnames(wtcell{1}.overall_avgs);

pvals=zeros(1,length(s));
significantpairs={};
for fnames=[1:3,5,7:8]%1:length(s)
    x=[];
    g=[];
    currnum=1;
    for i=1:length(u)
        currcat=bothcells(ic==i);
        for j=1:length(currcat)
            %x=[x;currcat{j}.overall_avgs.(s{fnames})];
            %g=[g;currnum*ones(size(currcat{j}.overall_avgs.(s{fnames})))];
            newv=currcat{j}.overall_vals.(s{fnames});
            
            % filter newv based on par exp range
            par=s{fnames};
            if strcmp(par,'dki_md') || strcmp(par,'dki_rd') || strcmp(par,'dki_ad')
            newv=newv(newv>.05e-3);
            elseif strcmp(par,'dki_fa') || strcmp(par,'kfa') || strcmp(par,'mk') || strcmp(par,'rk') || strcmp(par,'ak') || strcmp(par,'mkt')
            newv=newv(newv>0.01);
            elseif strcmp(par,'eval1') || strcmp(par,'eval2') || strcmp(par,'eval3')
            newv=newv(newv>.05e-3);
            end

            newv=rmoutliers(newv);
            x=[x;newv];
            g=[g;currnum*ones(size(newv))];

            currnum=currnum+1;

        end
    end

    %% This section performs statistical analysis
    [p,~,stats]=anova1(x,g,'off');
    pvals(fnames)=p;
    pairs=[];
    if p<.05
        c=multcompare(stats,'Display','off');
        pairs=c(squeeze(c(:,6))<.0005,1:2);
    end
    significantpairs{fnames}=pairs;
%% Violin plots
    %positions = grouped_boxplots(x,g,sort(category),categorynames,colors,legendnames);
    %grouped_violinplots(x,g,sort(category),categorynames,colors,legendnames); % for 1 timepoint data
    grouped_violinplots(x,g,sort(category),categorynames,colors,legendnames,1); % for 4 timepoint data
    title(upper(s{fnames}));

%     %Comment this out to not plot significance bars (including axis line after end)
%     for i=1:size(pairs,1)
%         dat=x(sum(g==pairs(i,:),2)>0);  % should only be 0's and 1's, but sum
%                                         % returns double and logical
%                                         % indexing require logical (hence
%                                         % the >0 comparison)
%         
%         hold on
%         plot(positions(pairs(i,:)), [1 1]*max(dat)*1.1, '-k',  mean(positions(pairs(i,:))), max(dat)*1.15, '*k')
%         
%     end
%     axis([xlim    min(x)/1.05  max(x)*1.15])

    
end