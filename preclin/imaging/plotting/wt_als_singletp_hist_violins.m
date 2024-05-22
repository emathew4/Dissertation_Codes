als170=als170m.fibersize;
wt170=wt170m.fibersize;
a=cat(2,wt170,als170);

x=[];
g=[];
for j=1:10
    curr=a(:,j);
    curr=rmoutliers(curr(~isnan(curr)));
    x=[x;curr];
g=[g;j*ones(size(curr))];
end

figure;vs=violinplot(x,g,'Showdata',false);
for i=1:length(vs)/2
vs(i).ViolinColor={[0 .447 .741]};
end
for i=6:10
vs(i).ViolinColor={[0.9 .1 .1]};
end
for i=1:length(vs)
vs(i).ViolinAlpha={.7};
end
xlim([0 11]);
xticks([]);
ylabel('Fiber Area (um^2)')
legend({'','WT Male','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','ALS Male'})