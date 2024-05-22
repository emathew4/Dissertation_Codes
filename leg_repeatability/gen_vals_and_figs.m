function [valout,cvs,pvals,ba_stats] = gen_vals_and_figs()

[valout,~]=get_all_means();
[cvs,~,cv_table]=within_subj_cv_calulator_segpar(valout);

[pvals,stats]=run_anova(valout,0); %change to 1 to display multcompare plots

ba_stats=plot_all_bland_altmans(valout,0); % 1 to show all plots, 0 if
% just want stats