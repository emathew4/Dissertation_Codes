function [cov_rhos, cov_ps] = mr_hist_cov_scatterplots(hist_covs,mr_covs)
%% use load('hist_covs.mat') and get_dti_coefvar to get covs
%  hist_covs.mat made using get_hist_covs.m
%
%% Get Spearman correlation results
[cov_rhos,cov_ps]=calc_cov_spearman_rhos(mr_covs,hist_covs);
%% Fiber Area Plots
% figure;scatter(hist_covs.fiberarea_covs,mr_covs.dti_ad,"filled")
% ylabel('Axial Diffusivity CV (%)');
% xlabel('Fiber Area (um^2)');
% text(0.65,0.14,['\rho = ' num2str(round(cov_rhos.dti_ad(1),2),'%1.2f')],'FontSize',16);
% text(0.65,0.13,['p = ' num2str(round(cov_ps.dti_ad(1),3),'%1.3f')],'FontSize',16);

figure;scatter(hist_covs.fiberarea_covs,mr_covs.dti_fa,"filled")
ylabel('Fractional Anisotropy CV (%)');
xlabel('Fiber Area (um^2)');
text(0.65,0.3,['\rho = ' num2str(round(cov_rhos.dti_fa(1),2),'%1.2f')],'FontSize',16);
text(0.65,0.285,['p = ' num2str(round(cov_ps.dti_fa(1),3),'%1.3f')],'FontSize',16);

figure;scatter(hist_covs.fiberarea_covs,mr_covs.dti_md,"filled")
ylabel('Mean Diffusivity CV (%)');
xlabel('Fiber Area (um^2)');
text(0.65,0.105,['\rho = ' num2str(round(cov_rhos.dti_md(1),2),'%1.2f')],'FontSize',16);
text(0.65,0.1,['p = ' num2str(round(cov_ps.dti_md(1),3),'%1.3f')],'FontSize',16);

figure;scatter(hist_covs.fiberarea_covs,mr_covs.dti_rd,"filled")
ylabel('Radial Diffusivity CV (%)');
xlabel('Fiber Area (um^2)');
text(0.65,0.095,['\rho = ' num2str(round(cov_rhos.dti_rd(1),2),'%1.2f')],'FontSize',16);
text(0.65,0.09,['p = ' num2str(round(cov_ps.dti_rd(1),3),'%1.3f')],'FontSize',16);

figure;scatter(hist_covs.fiberarea_covs,mr_covs.eval2,"filled")
ylabel('\lambda_2 CV (%)');
xlabel('Fiber Area (um^2)');
text(0.65,0.18,['\rho = ' num2str(round(cov_rhos.eval2(1),2),'%1.2f')],'FontSize',16);
text(0.65,0.17,['p = ' num2str(round(cov_ps.eval2(1),3),'%1.3f')],'FontSize',16);

figure;scatter(hist_covs.fiberarea_covs,mr_covs.eval3,"filled")
ylabel('\lambda_3 CV (%)');
xlabel('Fiber Area (um^2)');
text(0.65,0.255,['\rho = ' num2str(round(cov_rhos.eval3(1),2),'%1.2f')],'FontSize',16);
text(0.65,0.235,['p = ' num2str(round(cov_ps.eval3(1),3),'%1.3f')],'FontSize',16);

%% Min Feret Diameter Plots
% figure;scatter(hist_covs.mindiam_covs,mr_covs.dti_ad,"filled")
% ylabel('Axial Diffusivity CV (%)');
% xlabel('Minimum Fiber Diameter (um)');
% text(0.35,0.14,['\rho = ' num2str(round(cov_rhos.dti_ad(2),2),'%1.2f')],'FontSize',16);
% text(0.35,0.13,['p = ' num2str(round(cov_ps.dti_ad(2),3),'%1.3f')],'FontSize',16);

figure;scatter(hist_covs.mindiam_covs,mr_covs.dti_fa,"filled")
ylabel('Fractional Anisotropy CV (%)');
xlabel('Minimum Fiber Diameter (um)');
text(0.35,0.3,['\rho = ' num2str(round(cov_rhos.dti_fa(2),2),'%1.2f')],'FontSize',16);
text(0.35,0.285,['p = ' num2str(round(cov_ps.dti_fa(2),3),'%1.3f')],'FontSize',16);

figure;scatter(hist_covs.mindiam_covs,mr_covs.dti_md,"filled")
ylabel('Mean Diffusivity CV (%)');
xlabel('Minimum Fiber Diameter (um)');
text(0.35,0.105,['\rho = ' num2str(round(cov_rhos.dti_md(2),2),'%1.2f')],'FontSize',16);
text(0.35,0.1,['p = ' num2str(round(cov_ps.dti_md(2),3),'%1.3f')],'FontSize',16);

figure;scatter(hist_covs.mindiam_covs,mr_covs.dti_rd,"filled")
ylabel('Radial Diffusivity CV (%)');
xlabel('Minimum Fiber Diameter (um)');
text(0.35,0.095,['\rho = ' num2str(round(cov_rhos.dti_rd(2),2),'%1.2f')],'FontSize',16);
text(0.35,0.09,['p = ' num2str(round(cov_ps.dti_rd(2),3),'%1.3f')],'FontSize',16);

figure;scatter(hist_covs.mindiam_covs,mr_covs.eval2,"filled")
ylabel('\lambda_2 CV (%)');
xlabel('Minimum Fiber Diameter (um)');
text(0.35,0.18,['\rho = ' num2str(round(cov_rhos.eval2(2),2),'%1.2f')],'FontSize',16);
text(0.35,0.17,['p = ' num2str(round(cov_ps.eval2(2),3),'%1.3f')],'FontSize',16);

figure;scatter(hist_covs.mindiam_covs,mr_covs.eval3,"filled")
ylabel('\lambda_3 CV (%)');
xlabel('Minimum Fiber Diameter (um)');
text(0.35,0.255,['\rho = ' num2str(round(cov_rhos.eval3(2),2),'%1.2f')],'FontSize',16);
text(0.35,0.235,['p = ' num2str(round(cov_ps.eval3(2),3),'%1.3f')],'FontSize',16);

%% Max Feret Diameter Plots
% figure;scatter(hist_covs.maxdiam_covs,mr_covs.dti_ad,"filled")
% ylabel('Axial Diffusivity CV (%)');
% xlabel('Maximum Fiber Diameter (um)');
% text(0.31,0.14,['\rho = ' num2str(round(cov_rhos.dti_ad(3),2),'%1.2f')],'FontSize',16);
% text(0.31,0.13,['p = ' num2str(round(cov_ps.dti_ad(3),3),'%1.3f')],'FontSize',16);

figure;scatter(hist_covs.maxdiam_covs,mr_covs.dti_fa,"filled")
ylabel('Fractional Anisotropy CV (%)');
xlabel('Maximum Fiber Diameter (um)');
text(0.31,0.3,['\rho = ' num2str(round(cov_rhos.dti_fa(3),2),'%1.2f')],'FontSize',16);
text(0.31,0.285,['p = ' num2str(round(cov_ps.dti_fa(3),3),'%1.3f')],'FontSize',16);

figure;scatter(hist_covs.maxdiam_covs,mr_covs.dti_md,"filled")
ylabel('Mean Diffusivity CV (%)');
xlabel('Maximum Fiber Diameter (um)');
text(0.31,0.105,['\rho = ' num2str(round(cov_rhos.dti_md(3),2),'%1.2f')],'FontSize',16);
text(0.31,0.1,['p = ' num2str(round(cov_ps.dti_md(3),3),'%1.3f')],'FontSize',16);

figure;scatter(hist_covs.maxdiam_covs,mr_covs.dti_rd,"filled")
ylabel('Radial Diffusivity CV (%)');
xlabel('Maximum Fiber Diameter (um)');
text(0.31,0.095,['\rho = ' num2str(round(cov_rhos.dti_rd(3),2),'%1.2f')],'FontSize',16);
text(0.31,0.09,['p = ' num2str(round(cov_ps.dti_rd(3),3),'%1.3f')],'FontSize',16);

figure;scatter(hist_covs.maxdiam_covs,mr_covs.eval2,"filled")
ylabel('\lambda_2 CV (%)');
xlabel('Maximum Fiber Diameter (um)');
text(0.31,0.18,['\rho = ' num2str(round(cov_rhos.eval2(3),2),'%1.2f')],'FontSize',16);
text(0.31,0.17,['p = ' num2str(round(cov_ps.eval2(3),3),'%1.3f')],'FontSize',16);

figure;scatter(hist_covs.maxdiam_covs,mr_covs.eval3,"filled")
ylabel('\lambda_3 CV (%)');
xlabel('Maximum Fiber Diameter (um)');
text(0.31,0.255,['\rho = ' num2str(round(cov_rhos.eval3(3),2),'%1.2f')],'FontSize',16);
text(0.31,0.235,['p = ' num2str(round(cov_ps.eval3(3),3),'%1.3f')],'FontSize',16);