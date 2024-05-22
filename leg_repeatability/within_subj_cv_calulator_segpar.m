function [cvs, std_err, cv_table] = within_subj_cv_calulator_segpar(valout)
% Use valout from get_all_means

pars=fieldnames(valout); % parameter names
segs=fieldnames(valout.(pars{1}));
%segs={'mg','lg','sol','ta','pl','edl','tp'};

cvs=zeros(1,length(pars));  %
std_err=zeros(1,length(pars));

valout=rearrange_struct(valout);

for j=1:length(segs)
    mus=valout.(segs{j});
    clear cv_table
    for i=1:length(pars)
        mus.(pars{i})(any(isnan(mus.(pars{i})),2),:)=[];
        mus.(pars{i})(any(mus.(pars{i})<1e-3,2),:)=[];

        cv_table.(pars{i})(:,1)=(mus.(pars{i})(:,1)+mus.(pars{i})(:,2))/2;
        cv_table.(pars{i})(:,2)=mus.(pars{i})(:,2)-mus.(pars{i})(:,1);
        cv_table.(pars{i})(:,3)=(cv_table.(pars{i})(:,2)./cv_table.(pars{i})(:,1)).^2;

        cvs(j,i)=100*sqrt(sum(cv_table.(pars{i})(:,3))/(2*length(mus.(pars{i}))));
        std_err(j,i)=std(cv_table.(pars{i})(:,3))/sqrt(length(mus.(pars{i})));

    end
end

%% Bar plot of cvs
figure;bar(cvs');
set(gca,'XTickLabel',upper(pars),'FontSize',15)
ylabel('Within-subject Coefficient of Variation (%)','FontSize',15)
legend(cellfun(@upper,segs,'UniformOutput',0),'Location','bestoutside')
set(gca,'XColor',[0,0,0])
set(gca,'YColor',[0,0,0])
%yline([15,22],'--',{'15%','22%'},'LabelHorizontalAlignment','left');
%yline(15,'--',{'15%'},'LabelHorizontalAlignment','left');
set(gca,'box','off')