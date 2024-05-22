function structout = average_struct_vals(structin)

fields=fieldnames(structin);

for i=1:length(fields)
    par=structin.(fields{i});

    if strcmp(fields{i},'dki_md') || strcmp(fields{i},'dki_rd') || strcmp(fields{i},'dki_ad')
        par=par(par>.05e-3);
    elseif strcmp(fields{i},'dki_fa') || strcmp(fields{i},'kfa') || strcmp(fields{i},'mk') || strcmp(fields{i},'rk') || strcmp(fields{i},'ak') || strcmp(fields{i},'mkt')
        par=par(par>0.01);
    elseif strcmp(fields{i},'eval1') || strcmp(fields{i},'eval2') || strcmp(fields{i},'eval3')
        par=par(par>.05e-3);
    end
structout.(fields{i})=mean(par,[1,2,3]);

end