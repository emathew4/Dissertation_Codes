function mrconv_organizer()
% After using IRMaGe for Bruker data, can use this function to organize the
% Niftis into correct folder

% Remove .json files
delete *.json;

% Rename Niftis to get rid of '-' and change to '_'
d=dir('EM*.nii');
oldnames={d.name};  
intermed_names=strrep(oldnames,'-0','-');  
newnames=strrep(intermed_names,'-','_');

% Get folder number from each file from digits at end of name
out=regexp(intermed_names,'[-]\w+[.]','match'); % go from '-' to '.'
out=[out{:}];
fold_nums=cellfun(@(x) x(2:end-1), out, 'UniformOutput', false); % remove '-' and '.'

output_names=fullfile(fold_nums,newnames);

% Move renamed niftis into correct folder
for i=1:length(oldnames)
    movefile(oldnames{i},output_names{i})
end

% Delete log files
d=dir('log*');
if ~isempty(d)
    for i=1:length(d)
        delete(d(i).name)
    end
end

% Move bval and bvec files ** DON'T USE THIS; DOESN'T WORK FOR MULTIPLE
% SHELLS. USE BRUKERHELPER() INSTEAD TO CREATE .BVAL AND .BVEC FILES
% d=dir('*.txt');
% old_names={d.name};
% ind=regexp(old_names,'[-][b]');  % should be the same for both
% newb_names=cellfun(@(x) x(1:ind{1}-1),old_names,'UniformOutput',false);  % remove text after '-b'(val or vec)
% newb_names=strrep(newb_names,'-0','_');
% nums=cellfun(@(x) x(end),newb_names,'UniformOutput',false); % should be the same for both
% 
% bval_file=find(contains(old_names,'bval')); % figure out which one is bval file
% bvec_file=find(contains(old_names,'bvec')); % figure out which one is bvec file
% 
% bfilenames=fullfile(nums,newb_names);
% 
% bfilenames{bval_file}=[bfilenames{bval_file},'.bval'];
% bfilenames{bvec_file}=[bfilenames{bvec_file},'.bvec'];
% 
% for i=1:length(bfilenames)
%     movefile(old_names{i},bfilenames{i})
% end
