function valout = get_bulbar_avg_vals()

mainDir='/Users/ethanmathew/Desktop/BulbarRepeatability';
cd(mainDir);

d=dir('bulbar*');


for i=1:length(d)
    cd(d(i).name);
    cd('v1');
    vals1=get_dki_tongue_vals();
    [vals1.se,vals1.gre,vals1.dce] = get_fitted_avgs();
    cd('../v2');
    vals2=get_dki_tongue_vals();
    [vals2.se,vals2.gre,vals2.dce] = get_fitted_avgs();

    if i==1        
        valout=mergestructs(vals1,vals2,2);       
    else
        valout=mergestructs(valout,mergestructs(vals1,vals2,2),1);
    end
    cd(mainDir);
end
