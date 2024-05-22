function grouped_violinplots(x,g,category,categorynames,colors,legendnames,tp4)
% uses violinplot from bastibe https://github.com/bastibe/Violinplot-Matlab
% x and g are same x and g in boxplot.m documentation
% x is data to plot, all in one column
% g is grouping variable for boxes
%
% category is variable determining category of each group; should have one
% element for each unique group in g; i.e. if first two groups are in same
% category and second two groups are in the two different category then category =
% [1, 1, 2, 3]
% g and category should be ordered (i.e. groups within same category should
% be next to each other within g and x
%
% categorynames should contain name for each category in order
% length(categorynames) == length(unique(category))
%
% colors should contain color for each group using matlab single letter
% color names, (i.e. colors = ['r','c','r','y'] for 4 groups would plot 1st
% and 3rd group in same color)
% or can contain RGB triplets if colors is 3xn where n is number of groups
% and each column corresponds to RGB for that group
%
% legendnames should be legend for what each color represents in order
% of first appearance of color
% i.e. for above example, legendnames={'red,'cyan','yellow'}
% length(legendnames) == length(unique(colors))



% x=[wt70.overall_avgs.dki_md;als70.overall_avgs.dki_md;wt110.overall_avgs.dki_md;als110.overall_avgs.dki_md];
% g=[zeros(size(wt70.overall_avgs.dki_md));ones(size(als70.overall_avgs.dki_md));2*ones(size(wt110.overall_avgs.dki_md));3*ones(size(als110.overall_avgs.dki_md))];
%% Check Inputs
arguments
    x (:,1)
    g (:,1)
    category (:,1)
    categorynames = unique(category);
    colors = [];
    legendnames = [];
    tp4 = false;
end

if length(x)~=length(g)
    error('Sizes of data and grouping don''t match')
end

if length(unique(g))<length(category)
    error('Too many categories for given groups')
elseif length(unique(g))>length(category)
    error('Not every group assigned a category')
end

if ~isempty(colors) && length(category)~=length(colors)
    error('Number of colors does not match number of groups')
end

if length(unique(category))~=length(categorynames)
    error('Number of categories does not match number of category names')
end

% if length(legendnames) ~= size(unique(colors','rows'),1)
%     error('Number of legend entries does not match number of colors')
% end
%% Create positions vector and xtick locations vector

figure;vs=violinplot(x,g,'ShowData',false);
if tp4
    tickpos=2.5:4:14.5; %comment out for only 1 timepoint
    set(gca,'xtick',tickpos)    % comment out for only 1 timepoint
end
set(gca,'xticklabel',categorynames)

if ~isempty(colors)
    if tp4
        xline([4.5,8.5,12.5],'--k'); %comment out for only 1 timepoint
    end
    for i=1:size(colors,2)
        vs(i).ViolinColor={colors(:,i)'};

        if mod(i,4)==0 || mod(i,4)==3
            vs(i).ViolinAlpha={.2};
        else
            vs(i).ViolinAlpha={.7};
        end

    end

    c = get(gca, 'Children');
    if ~isempty(legendnames)
        legend(c(end-(1:8:26)), legendnames,'AutoUpdate','off');
    end
end