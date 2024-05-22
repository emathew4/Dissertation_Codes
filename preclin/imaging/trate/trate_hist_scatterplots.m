function trate_hist_scatterplots(hist_avgs,trate_avgs)
%% use calc_trate_spearman_rhos to get hist_avgs and trate_avgs
%
%
%% TRATE vs Histology Plots
figure;scatter(hist_avgs(:,1),trate_avgs,"filled")
ylabel('TRATE (mM^-^1s^-^1)');
xlabel('Fiber Area (um^2)');
text(4400,550,'\rho = 0.009','FontSize',16);
text(4400,525,'p = 0.938','FontSize',16);

figure;scatter(hist_avgs(:,2),trate_avgs,"filled")
ylabel('TRATE (mM^-^1s^-^1)');
xlabel('Minimum Fiber Diameter (um)');
text(63,550,'\rho = 0.061','FontSize',16);
text(63,525,'p = 0.602','FontSize',16);

figure;scatter(hist_avgs(:,3),trate_avgs,"filled")
ylabel('TRATE (mM^-^1s^-^1)');
xlabel('Maximum Fiber Diameter (um)');
text(96,550,'\rho = 0.002','FontSize',16);
text(96,525,'p = 0.984','FontSize',16);

figure;scatter(hist_avgs(:,4),trate_avgs,"filled")
ylabel('TRATE (mM^-^1s^-^1)');
xlabel('Cell density (cells/mm^2)')
text(435,550,'\rho = -0.009','FontSize',16);
text(435,525,'p = 0.941','FontSize',16);