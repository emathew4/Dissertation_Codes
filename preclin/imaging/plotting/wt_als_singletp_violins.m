wt_als_violins
% Set breakpoints in wt_als_violins after "d=dir()" line and at "end" of
% plotting loop
d(1:10)=[];
d(6:10)=[];
d(11:end)=[];
% Rearrange for als to come after wt
d(11:15)=d(1:5);
d(1:5)=[];
dbcont
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
ylabel('Diffusivity (mm^2/s)')
% Put M or F (or Male/Female) in legend labelling below
legend({'','WT','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','ALS'})