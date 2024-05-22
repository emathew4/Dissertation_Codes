function [cvs, std_err, cv_table] = bulbar_wscv(vals)
% Use valout from get_all_means

pars=fieldnames(vals); % parameter names

cvs=zeros(1,length(pars));  %
std_err=zeros(1,length(pars));

%valout=rearrange_struct(valout);

for i=1:length(pars)
    cv_table.(pars{i})(:,1)=(vals.(pars{i})(:,1)+vals.(pars{i})(:,2))/2;
    cv_table.(pars{i})(:,2)=vals.(pars{i})(:,2)-vals.(pars{i})(:,1);
    cv_table.(pars{i})(:,3)=(cv_table.(pars{i})(:,2)./cv_table.(pars{i})(:,1)).^2;

    cvs(i)=100*sqrt(sum(cv_table.(pars{i})(:,3))/(2*length(vals.(pars{i}))));
    std_err(i)=std(cv_table.(pars{i})(:,3))/sqrt(length(vals.(pars{i})));
end
cvs=table(pars,cvs','VariableNames',{'Metric','wsCV'});
%% Bar plot of cvs
% figure;bar(cvs');
% set(gca,'XTickLabel',upper(pars),'FontSize',15)
% ylabel('Within-subject Coefficient of Variation (%)','FontSize',15)
% legend(cellfun(@upper,segs,'UniformOutput',0),'Location','bestoutside')
% set(gca,'XColor',[0,0,0])
% set(gca,'YColor',[0,0,0])
% %yline([15,22],'--',{'15%','22%'},'LabelHorizontalAlignment','left');
% %yline(15,'--',{'15%'},'LabelHorizontalAlignment','left');
% set(gca,'box','off')