function covs=get_hist_covs(foldername,sheetnum)
arguments
    foldername char = 'askwhich'
    sheetnum (1,1) int16 = 1    % fiber area = 1, min diam = 2, max diam = 3
end

mainDir='/Users/ethanmathew/Desktop/ALS_Preclin_2022/Histology_Data_Functions/';
a=dir(mainDir);
a(~[a.isdir])=[];
b={a.name};
b(startsWith(b,'.'))=[];

if matches(foldername,'askwhich')
    
    fprintf("Please choose from:\n")
    for i=1:length(b)
        fprintf("%i. %s\t",i,b{i})
    end
    fprintf("\n")
    num=input('Please enter which number folder you would like to use. Type the number followed by ENTER\n');
    covs = get_hist_covs(b{num},sheetnum);
elseif sum(matches(b,foldername))~=1
    fprintf('Please enter a valid folder name in %s',mainDir)
else

    % Change Muscle Folder and Sheet # in below line to manually change which metric COV is calc
    fiberarea=readmatrix(['/Users/ethanmathew/Desktop/ALS_Preclin_2022/Histology_Data_Functions/',foldername,'/All_Animals_Hist_Data.xlsx'],'Sheet',sheetnum);
    a=std(fiberarea,0,1,'omitnan');
    b=mean(fiberarea,'omitnan');
    covs=a./b;
end