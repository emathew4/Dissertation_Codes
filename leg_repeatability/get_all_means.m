function [valout,stdout]=get_all_means()
cd '/Volumes/My Passport for Mac/Repeatability_Analysis'

folds=dir('HC*');
curr=pwd;

for i=1:length(folds)
    cd(folds(i).name)
    try
        %[vals,stds]=extract_all_vals_masked; % for if combined l/r
        [lvals,rvals,lstds,rstds]=extract_all_vals_masked;
        if i==1
            %valout=vals;
            %stdout=stds;
            valout=mergestructs(lvals,rvals,2);
            stdout=mergestructs(lstds,rstds,2);
            
        else
            %valout=mergestructs(valout,vals,2);
            %stdout=mergestructs(stdout,stds,2);
            valout=mergestructs(valout,mergestructs(lvals,rvals,2),2);
            stdout=mergestructs(stdout,mergestructs(lstds,rstds,2),2);
        end
    catch
        pwd
        cd(curr)
    end
    cd(curr);
end