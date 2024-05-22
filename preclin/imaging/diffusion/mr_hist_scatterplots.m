function mr_hist_scatterplots(hist_avgs,mr_avgs)
%% use calc_spearman_rhos to get hist_avgs and mr_avgs
%
%
%% Just plotting Mean Diffusivity vs Fiber Area here
% figure;scatter(hist_avgs(:,1),mr_avgs(:,3),"filled")
% ylabel('Mean diffusivity (mm^2/s)');
% xlabel('Fiber Area (um^2)');
% text(4400,1.5e-3,'\rho = 0.40','FontSize',16);
% text(4400,1.45e-3,'p = 2e-4','FontSize',16);
%% Fiber Area Plots
figure;scatter(hist_avgs(:,1),mr_avgs(:,1),"filled")
ylabel('Axial diffusivity (mm^2/s)');
xlabel('Fiber Area (um^2)');
text(4400,1.65e-3,'\rho = 0.34','FontSize',16);
text(4400,1.625e-3,'p = 0.002','FontSize',16);

figure;scatter(hist_avgs(:,1),mr_avgs(:,2),"filled")
ylabel('Fractional Anisotropy');
xlabel('Fiber Area (um^2)');
text(4400,.24,'\rho = -0.33','FontSize',16);
text(4400,.235,'p = 0.003','FontSize',16);

figure;scatter(hist_avgs(:,1),mr_avgs(:,3),"filled")
ylabel('Mean diffusivity (mm^2/s)');
xlabel('Fiber Area (um^2)');
text(4400,1.4e-3,'\rho = 0.40','FontSize',16);
text(4400,1.375e-3,'p = 2e-4','FontSize',16);

figure;scatter(hist_avgs(:,1),mr_avgs(:,4),"filled")
ylabel('Radial Diffusivity (mm^2/s)');
xlabel('Fiber Area (um^2)');
text(4400,1.25e-3,'\rho = 0.42','FontSize',16);
text(4400,1.225e-3,'p = 1e-4','FontSize',16);

figure;scatter(hist_avgs(:,1),mr_avgs(:,5),"filled")
ylabel('\lambda_2 Diffusivity (mm^2/s)');
xlabel('Fiber Area (um^2)');
text(4400,1.3e-3,'\rho = 0.39','FontSize',16);
text(4400,1.275e-3,'p = 3e-4','FontSize',16);

figure;scatter(hist_avgs(:,1),mr_avgs(:,6),"filled")
ylabel('\lambda_3 diffusivity (mm^2/s)');
xlabel('Fiber Area (um^2)');
text(4400,1.2e-3,'\rho = 0.42','FontSize',16);
text(4400,1.175e-3,'p = 1e-4','FontSize',16);
%% Min Feret Diameter Plots
figure;scatter(hist_avgs(:,2),mr_avgs(:,1),"filled")
ylabel('Axial diffusivity (mm^2/s)');
xlabel('Minimum Fiber Diameter (um)');
text(63,1.65e-3,'\rho = 0.32','FontSize',16);
text(63,1.625e-3,'p = 0.003','FontSize',16);

figure;scatter(hist_avgs(:,2),mr_avgs(:,2),"filled")
ylabel('Fractional Anisotropy');
xlabel('Minimum Fiber Diameter (um)');
text(63,.24,'\rho = -0.29','FontSize',16);
text(63,.235,'p = 0.009','FontSize',16);

figure;scatter(hist_avgs(:,2),mr_avgs(:,3),"filled")
ylabel('Mean diffusivity (mm^2/s)');
xlabel('Minimum Fiber Diameter (um)');
text(63,1.4e-3,'\rho = 0.39','FontSize',16);
text(63,1.375e-3,'p = 3e-4','FontSize',16);

figure;scatter(hist_avgs(:,2),mr_avgs(:,4),"filled")
ylabel('Radial Diffusivity (mm^2/s)');
xlabel('Minimum Fiber Diameter (um)');
text(63,1.25e-3,'\rho = 0.40','FontSize',16);
text(63,1.225e-3,'p = 1e-4','FontSize',16);

figure;scatter(hist_avgs(:,2),mr_avgs(:,5),"filled")
ylabel('\lambda_2 Diffusivity (mm^2/s)');
xlabel('Minimum Fiber Diameter (um)');
text(63,1.3e-3,'\rho = 0.38','FontSize',16);
text(63,1.275e-3,'p = 5e-4','FontSize',16);

figure;scatter(hist_avgs(:,2),mr_avgs(:,6),"filled")
ylabel('\lambda_3 diffusivity (mm^2/s)');
xlabel('Minimum Fiber Diameter (um)');
text(63,1.2e-3,'\rho = 0.39','FontSize',16);
text(63,1.175e-3,'p = 4e-4','FontSize',16);
%% Max Feret Diameter Plots
figure;scatter(hist_avgs(:,3),mr_avgs(:,1),"filled")
ylabel('Axial diffusivity (mm^2/s)');
xlabel('Maximum Fiber Diameter (um)');
text(96,1.65e-3,'\rho = 0.33','FontSize',16);
text(96,1.625e-3,'p = 0.003','FontSize',16);

figure;scatter(hist_avgs(:,3),mr_avgs(:,2),"filled")
ylabel('Fractional Anisotropy');
xlabel('Maximum Fiber Diameter (um)');
text(96,.24,'\rho = -0.35','FontSize',16);
text(96,.235,'p = 0.002','FontSize',16);

figure;scatter(hist_avgs(:,3),mr_avgs(:,3),"filled")
ylabel('Mean diffusivity (mm^2/s)');
xlabel('Maximum Fiber Diameter (um)');
text(96,1.4e-3,'\rho = 0.39','FontSize',16);
text(96,1.375e-3,'p = 3e-4','FontSize',16);

figure;scatter(hist_avgs(:,3),mr_avgs(:,4),"filled")
ylabel('Radial Diffusivity (mm^2/s)');
xlabel('Maximum Fiber Diameter (um)');
text(96,1.25e-3,'\rho = 0.41','FontSize',16);
text(96,1.225e-3,'p = 1e-4','FontSize',16);

figure;scatter(hist_avgs(:,3),mr_avgs(:,5),"filled")
ylabel('\lambda_2 Diffusivity (mm^2/s)');
xlabel('Maximum Fiber Diameter (um)');
text(96,1.3e-3,'\rho = 0.38','FontSize',16);
text(96,1.275e-3,'p = 6e-4','FontSize',16);

figure;scatter(hist_avgs(:,3),mr_avgs(:,6),"filled")
ylabel('\lambda_3 diffusivity (mm^2/s)');
xlabel('Maximum Fiber Diameter (um)');
text(96,1.2e-3,'\rho = 0.41','FontSize',16);
text(96,1.175e-3,'p = 2e-4','FontSize',16);
%% Cell Density Plots
figure;scatter(hist_avgs(:,4),mr_avgs(:,1),"filled")
ylabel('Axial diffusivity (mm^2/s)');
xlabel('Cell density (cells/mm^2)');
text(435,1.65e-3,'\rho = -0.36','FontSize',16);
text(435,1.625e-3,'p = 0.001','FontSize',16);

figure;scatter(hist_avgs(:,4),mr_avgs(:,2),"filled")
ylabel('Fractional Anisotropy');
xlabel('Cell density (cells/mm^2)')
text(435,.24,'\rho = 0.35','FontSize',16);
text(435,.235,'p = 0.002','FontSize',16);

figure;scatter(hist_avgs(:,4),mr_avgs(:,3),"filled")
ylabel('Mean diffusivity (mm^2/s)');
xlabel('Cell density (cells/mm^2)')
text(435,1.4e-3,'\rho = -0.42','FontSize',16);
text(435,1.375e-3,'p = 1e-4','FontSize',16);

figure;scatter(hist_avgs(:,4),mr_avgs(:,4),"filled")
ylabel('Radial Diffusivity (mm^2/s)');
xlabel('Cell density (cells/mm^2)')
text(435,1.25e-3,'\rho = -0.44','FontSize',16);
text(435,1.225e-3,'p = 5e-5','FontSize',16);

figure;scatter(hist_avgs(:,4),mr_avgs(:,5),"filled")
ylabel('\lambda_2 Diffusivity (mm^2/s)');
xlabel('Cell density (cells/mm^2)')
text(435,1.3e-3,'\rho = -0.41','FontSize',16);
text(435,1.275e-3,'p = 2e-4','FontSize',16);

figure;scatter(hist_avgs(:,4),mr_avgs(:,6),"filled")
ylabel('\lambda_3 diffusivity (mm^2/s)');
xlabel('Cell density (cells/mm^2)')
text(435,1.2e-3,'\rho = -0.49','FontSize',16);
text(435,1.175e-3,'p = 9e-5','FontSize',16);