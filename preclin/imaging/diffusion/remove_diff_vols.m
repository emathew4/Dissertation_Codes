function remove_diff_vols(inds_to_remove)
filename='dkitorun';

dki=niftiread([filename,'.nii']);
dki(:,:,:,inds_to_remove)=[]; % remove bad diffusion volumes
niftiwrite(dki,[filename,'.nii']); % save new data

bvals=fscanf(fopen([filename,'.bval'],'r'),'%f');   % read all bvals
bvecs=readmatrix([filename,'.bvec'],'FileType','text'); % read all bvecs
fclose('all');

bvals(inds_to_remove)=[]; % remove bval values for bad volumes
bvecs(:,inds_to_remove)=[]; % remove bvec values for bad volumes

fid=fopen(strcat(filename,'.bval'),'w');    % rewrite new bvals
fprintf(fid,'%s\n',bvals);
fclose(fid);


bvecprint=repmat('%g ',1,size(bvecs,2)); % formatting for printing bvecs
bvecprint=strcat(bvecprint(1:end-1),'\n');

fid=fopen(strcat(filename,'.bvec'),'w');    % rewrite new bvecs
fprintf(fid,bvecprint,bvecs');
fclose(fid);