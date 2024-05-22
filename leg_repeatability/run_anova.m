function [p_out,stats]=run_anova(valout,display)

if nargin==1 || isempty(display)
    display=1;
end

%[valout,~]=get_all_means;

f1=fieldnames(valout);
f2=fieldnames(valout.(f1{1}));

v=rearrange_struct(valout);

for ii=1:length(f2)
    newv.(f2{ii})=structfun(@rmmissing,v.(f2{ii}),'UniformOutput',false);
end

for ii = 1:length(f1)
    tmp = cellfun(@(a) newv.(a).(f1{ii}), f2, 'uni', 0);
    A.(f1{ii}) = cat(1, tmp{:});
end

for i=1:length(f1)
    getridval=A.(f1{i});
    A.(f1{i})=getridval(:,1);
end

valoutout=rearrange_struct(v,true);

for ii=1:length(f1)
    newvalout.(f1{ii})=structfun(@rmmissing,valoutout.(f1{ii}),'UniformOutput',false);
end

for i=1:length(f1)
    inds=[];
    for j=1:length(f2)
        inds=[inds,ones(1,size(newvalout.(f1{i}).(f2{j}),1))*j];
    end
    B.(f1{i})=inds;
end

for i=1:length(f1)
    [p,tbl,stats]=anova1(A.(f1{i}),B.(f1{i}),'off');
    p_out(i)=p;
    if ~display
        c=multcompare(stats,"Display","off");
    else
        figure;
        c=multcompare(stats);
    end
end