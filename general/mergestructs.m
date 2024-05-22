function struct1 = mergestructs(struct1, struct2,dim)
% Since structs have same fieldnames/sizes, no data checking
fields=fieldnames(struct1);
for i=1:length(fields)
    curr_field=fields{i};
    struct1.(curr_field)=cat(dim,struct1.(curr_field), struct2.(curr_field));
end
end