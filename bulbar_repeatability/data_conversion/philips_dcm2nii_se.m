function [dcmhdr] = philips_dcm2nii_se(dcmfile,numEchos)

if nargin<2
    numEchos=1;
end

if ~iscellstr(dcmfile)
    if ischar(dcmfile)
        dcmfile = {dcmfile};
    else
        error('Invalid file name')
    end
end

tmp = clock;
disp('-------------------------------------------------------------------')
fprintf('(%.2d:%.2d:%02.0f) Running %s.m...\n',...
    tmp(4),tmp(5),tmp(6),mfilename)


num_dcmfiles = length(dcmfile);

for ff=1:num_dcmfiles % loop for all the files

    fprintf('- File %d/%d:\n',ff,num_dcmfiles)


    % Read DICOM file
    %==========================================================================
    fprintf('  Reading DICOM data...')
    data = dicomread(dcmfile{ff});
    data = squeeze(data); % Philips R2.6: 3rd dimension is useless
    fprintf(' Done!\n')


    % Read the DICOM header
    %==========================================================================
    fprintf('  Reading DICOM header...')
    dcmhdr    = dicominfo(dcmfile{ff});
    Nslices   = dcmhdr.Private_2001_1018;
    data=data(:,:,1:end-Nslices); % get rid of extraneous data
    %Ngrad     = dcmhdr.NumberOfFrames / Nslices;
    TR        = dcmhdr.SharedFunctionalGroupsSequence.Item_1.MRTimingAndRelatedParametersSequence.Item_1.RepetitionTime / 1000;
    voxel_sz  = [dcmhdr.PerFrameFunctionalGroupsSequence.Item_1.PixelMeasuresSequence.Item_1.PixelSpacing;
        dcmhdr.PerFrameFunctionalGroupsSequence.Item_1.PixelMeasuresSequence.Item_1.SpacingBetweenSlices];
    % dcmhdr.PerFrameFunctionalGroupsSequence.Item_1.PixelMeasuresSequence.Item_1.SliceThickness
    scl_slope = dcmhdr.PerFrameFunctionalGroupsSequence.Item_1.PixelValueTransformationSequence.Item_1.RescaleSlope;
    % also in dcmhdr.PerFrameFunctionalGroupsSequence.Item_1.Private_2005_140f.Item_1.RescaleSlope
    scl_inter = dcmhdr.PerFrameFunctionalGroupsSequence.Item_1.PixelValueTransformationSequence.Item_1.RescaleIntercept;
    % also in dcmhdr.PerFrameFunctionalGroupsSequence.Item_1.Private_2005_140f.Item_1.RescaleIntercept
    fprintf(' Done!\n')


    % Reshape the data
    %==========================================================================
    fprintf('  Creating NIfTI image...')
    % X x Y x Z x G
    % DX x DY x 1 x DZ*NGRAD --> DX x DY x DZ x NGRAD

    slc = 1:Nslices;

    grad = 1:numEchos;

    tmp = zeros(size(data,1),size(data,2),Nslices,numEchos,'uint16');
    for gg=grad
        for ss=slc
            tmp(:,:,ss,gg) = data(:,:,gg+(ss-1)*numEchos);
        end
    end

    % ~30x slower than the above:
    % for ss=1:Nslices
    %     tmp(:,:,ss,1:Ngrad) = data(:,:,((ss-1)*Ngrad+1):(ss*Ngrad));
    % end

    % Eliminate slices and gradients
    %--------------------------------------------------------------------------

    % data = permute(tmp,[2 1 3 4]);
    % data = flipdim(data,1);
    % data = flipdim(data,2);
    % data=tmp;

    data=squeeze(reshape_philips_dki(data,'NumSlices',Nslices,'NumBVal',numEchos));


    % File name
    %==========================================================================
    [fpath,fname] = fileparts(dcmfile{ff}); % exclude file extension if there is one
    if isempty(fpath)
        fpath = pwd;
    end
    fname = [fname '.nii'];


    % Get the orientation matrix
    %==========================================================================

    % Plane orientation (all planes have the same orientation)
    orient = dcmhdr.PerFrameFunctionalGroupsSequence.Item_1.PlaneOrientationSequence.Item_1.ImageOrientationPatient;

    % Rotation matrix
    rot = [orient(1) orient(4);
        orient(2) orient(5);
        -orient(3) -orient(6)];
    rot(:,3) = null(rot');
    qfactor  = 1;
    if det(rot)<0
        rot(:,3) = -rot(:,3);
        %qfactor  = -1;
    end
    % explanation for why it is done this way at:
    % http://nifti.nimh.nih.gov/nifti-1/documentation/nifti1fields/nifti1fields_pages/quatern.html

    % Make sure it is really orthogonal (using polar decomposition)
    [U,~,V] = svd(rot);
    rot     = U*V';

    % Choose the origin as the center of the matrix
    origin = round([size(data,1) ; size(data,2) ; size(data,3)]/2);

    % Orientation matrix
    mat = [ [rot ; [0 0 0]] [-rot*(origin.*voxel_sz) ; 1]] .* ...
        [voxel_sz' 1; voxel_sz' 1; voxel_sz' 1; 0 0 0 1];
    % origin: O=mat\[0 0 0 1]'; O=O(1:3);
    % same as: O=inv(mat); O=O(1:3,4);

    % Using the "Tools for NIfTI and ANALYZE image", by Jimmy Shen
    %--------------------------------------------------------------
    % Necessary functions: make_nii, save_nii, save_nii_ext, save_nii_hdr,
    % verify_nii_ext
    nii = make_nii(data,voxel_sz',origin,4,['converted from DICOM using ' mfilename]);
    nii.hdr.dime.pixdim(1)  = qfactor;
    nii.hdr.dime.pixdim(5)  = TR;
    nii.hdr.dime.vox_offset = 352;
    nii.hdr.dime.scl_slope  = scl_slope;
    nii.hdr.dime.scl_inter  = scl_inter;
    nii.hdr.dime.xyzt_units = 10; % mm and s

    % Rotation matrix in quaternion representation. Based on:
    % - http://nifti.nimh.nih.gov/nifti-1/documentation/nifti1fields/nifti1fields_pages/quatern.html
    % - mat44_to_quatern()
    nii.hdr.hist.qform_code = 1;
    nii.hdr.hist.sform_code = 1;
    quatern_a = 1 + sum(diag(rot));
    if quatern_a > .5
        quatern_a = .5 * sqrt(quatern_a); % not stored
        quatern_b = .25*(rot(3,2)-rot(2,3))/quatern_a;
        quatern_c = .25*(rot(1,3)-rot(3,1))/quatern_a;
        quatern_d = .25*(rot(2,1)-rot(1,2))/quatern_a;
    else
        xd = 1 + rot(1,1) - rot(2,2) - rot(3,3);
        yd = 1 + rot(2,2) - rot(1,1) - rot(3,3);
        zd = 1 + rot(3,3) - rot(1,1) - rot(2,2);
        if xd > 1
            quatern_b = .5 * sqrt(xd);
            quatern_c = .25 * (rot(1,2)+rot(2,1)) / quatern_b;
            quatern_d = .25 * (rot(1,3)+rot(3,1)) / quatern_b;
            quatern_a = .25 * (rot(3,2)-rot(2,3)) / quatern_b;
        elseif yd > 1
            quatern_c = .5 * sqrt(yd);
            quatern_b = .25 * (rot(1,2)+rot(2,1)) / quatern_c;
            quatern_d = .25 * (rot(2,3)+rot(3,2)) / quatern_c;
            quatern_a = .25 * (rot(1,3)-rot(3,1)) / quatern_c;
        else
            quatern_d = .5 * sqrt(zd);
            quatern_b = .25 * (rot(1,3)+rot(3,1)) / quatern_d;
            quatern_c = .25 * (rot(2,3)+rot(3,2)) / quatern_d;
            quatern_a = .25 * (rot(2,1)-rot(1,2)) / quatern_d;
        end
        if quatern_a < 0
            %quatern_a = -quatern_a;
            quatern_b = -quatern_b;
            quatern_c = -quatern_c;
            quatern_d = -quatern_d;
        end
    end
    nii.hdr.hist.quatern_b = quatern_b;
    nii.hdr.hist.quatern_c = quatern_c;
    nii.hdr.hist.quatern_d = quatern_d;


    nii.hdr.hist.qoffset_x = sum(mat(1,1:3),2) + mat(1,4);
    nii.hdr.hist.qoffset_y = sum(mat(2,1:3),2) + mat(2,4);
    nii.hdr.hist.qoffset_z = sum(mat(3,1:3),2) + mat(3,4);
    nii.hdr.hist.srow_x    = [mat(1,1:3) nii.hdr.hist.qoffset_x];
    nii.hdr.hist.srow_y    = [mat(2,1:3) nii.hdr.hist.qoffset_y];
    nii.hdr.hist.srow_z    = [mat(3,1:3) nii.hdr.hist.qoffset_z];
    nii.hdr.hist.magic     = 'n+1';
    save_nii(fliplr(rot90(nii)),fullfile(fpath,fname))

    fprintf(' Done!\n')
    %fprintf('  %s was created in %s\n',fname,fpath)

end