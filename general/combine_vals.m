function combined_vals = combine_vals(vals1,vals2)

fnames=fieldnames(vals1);

if ~isempty(setdiff(fnames,fieldnames(vals2)))
    error('The two structs to combine have at least one different field. Fieldnames must match exactly')

end

for i=1:length(fnames)
    par=fnames{i};
    combined_vals.(par)=[vals1.(par);vals2.(par)];
end

end