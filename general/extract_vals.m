function vals = extract_vals(pars,mask)
% adjust filtering cutoff values based on anatomy being imaged and fitting
% quality
parnames=fieldnames(pars);

for par=1:length(parnames)
    fname=parnames{par};

    if strcmp(fname,'dki_primdir') || strcmp(fname,'dki_tensor')
        continue
    end
    allvals=mask.*pars.(fname);

    if strcmp(fname,'kfa') || strcmp(fname,'fa')
        allvals(allvals>.8)=[]; 
        allvals(allvals<0.01)=[];
    end

    if strcmp(fname,'dki_md') || strcmp(fname,'dki_rd') || strcmp(fname,'dki_ad') || strcmp(fname,'dti_md') || strcmp(fname,'dti_rd') || strcmp(fname,'dti_ad') || strcmp(fname,'evals') || strcmp(fname,'md') || strcmp(fname,'rd') || strcmp(fname,'ad')
            allvals(allvals<.5e-3)=[];
            allvals(allvals>3e-3)=[];
    end
    
    if strcmp(fname,'mk') || strcmp(fname,'ak') || strcmp(fname,'rk') || strcmp(fname,'mkt')
        allvals(allvals>1)=[];
        allvals(allvals<.01)=[];
    end

    allvals=nonzeros(allvals(~isnan(allvals)));
    
    while 1
        num=numel(allvals);
        allvals=rmoutliers(allvals,'mean');
        if num==numel(allvals)
            break
        end
        
    end
    vals.(fname)=allvals;
    %vals.(fname)=rmoutliers(nonzeros(allvals));
end

% comb_vals_par = [parvals1; parvals2; ...];