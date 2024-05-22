import numpy as np
import nibabel as nib
import dipy.reconst.dki as dki
import dipy.reconst.dti as dti
from dipy.core.gradients import gradient_table
from dipy.io.gradients import read_bvals_bvecs
from dipy.io.image import load_nifti, save_nifti
from dipy.segment.mask import median_otsu
import os
import matlab.engine
from dipy.denoise.patch2self import patch2self
from dipy.denoise.localpca import mppca
from dipy.denoise.gibbs import gibbs_removal


def save_dki_outputs(dkifit, output, affine):
    FA = dkifit.fa
    MD = dkifit.md
    AD = dkifit.ad
    RD = dkifit.rd
    MK = dkifit.mk(0, 3)
    AK = dkifit.ak(0, 3)
    RK = dkifit.rk(0, 3)
    MKT = dkifit.mkt(0, 3)
    KFA = dkifit.kfa
    dirs = dkifit.directions
    kt = dkifit.kt

    color_fa = dkifit.color_fa
    evals = dkifit.evals
    evecs = dkifit.evecs
    ga = dkifit.ga
    linearity = dkifit.linearity

    FAname = output + '/dki_fa.nii.gz'
    MDname = output + '/dki_md.nii.gz'
    ADname = output + '/dki_ad.nii.gz'
    RDname = output + '/dki_rd.nii.gz'
    MKname = output + '/mk.nii.gz'
    AKname = output + '/ak.nii.gz'
    RKname = output + '/rk.nii.gz'
    MKTname = output + '/mkt.nii.gz'
    KFAname = output + '/kfa.nii.gz'
    dirsname = output + '/dki_primdir.nii.gz'
    ktname = output + '/dki_tensor.nii.gz'

    colorname = output + '/colorfa.nii.gz'
    evalsname = output + '/evals.nii.gz'
    evecsname = output + '/evecs.nii.gz'
    ganame = output + '/ga.nii.gz'
    linname = output + '/linearity.nii.gz'

    # Uncomment below which ones to save if you want

    # save_nifti(colorname, color_fa.astype(np.float32), affine)
    save_nifti(evalsname, evals.astype(np.float32), affine)
    save_nifti(evecsname, evecs.astype(np.float32), affine)
    # save_nifti(ganame, ga.astype(np.float32), affine)
    # save_nifti(linname, linearity.astype(np.float32), affine)

    save_nifti(FAname, FA.astype(np.float32), affine)
    save_nifti(MDname, MD.astype(np.float32), affine)
    save_nifti(ADname, AD.astype(np.float32), affine)
    save_nifti(RDname, RD.astype(np.float32), affine)
    save_nifti(MKname, MK.astype(np.float32), affine)
    save_nifti(AKname, AK.astype(np.float32), affine)
    save_nifti(RKname, RK.astype(np.float32), affine)
    save_nifti(MKTname, MKT.astype(np.float32), affine)
    save_nifti(KFAname, KFA.astype(np.float32), affine)
    save_nifti(dirsname, dirs.astype(np.float32), affine)
    save_nifti(ktname, kt.astype(np.float32), affine)

    eng = matlab.engine.start_matlab()
    eng.dipyhelperdki(output, nargout=0)
    eng.exit()


def save_dti_outputs(tenfit, output, affine):
    FA = tenfit.fa
    MD = tenfit.md
    AD = tenfit.ad
    RD = tenfit.rd
    dirs = tenfit.directions

    color_fa = tenfit.color_fa
    evals = tenfit.evals
    evecs = tenfit.evecs
    ga = tenfit.ga
    linearity = tenfit.linearity

    FAname = output + '/dti_fa.nii.gz'
    MDname = output + '/dti_md.nii.gz'
    ADname = output + '/dti_ad.nii.gz'
    RDname = output + '/dti_rd.nii.gz'
    dirsname = output + '/dti_primdir.nii.gz'

    colorname = output + '/dti_colorfa.nii.gz'
    evalsname = output + '/dti_evals.nii.gz'
    evecsname = output + '/dti_evecs.nii.gz'
    ganame = output + '/dti_ga.nii.gz'
    linname = output + '/dti_linearity.nii.gz'

    save_nifti(FAname, FA.astype(np.float32), affine)
    save_nifti(MDname, MD.astype(np.float32), affine)
    save_nifti(ADname, AD.astype(np.float32), affine)
    save_nifti(RDname, RD.astype(np.float32), affine)
    save_nifti(dirsname, dirs.astype(np.float32), affine)

    # Uncomment below which ones to save if you want

    # save_nifti(colorname, color_fa.astype(np.float32), affine)
    save_nifti(evalsname, evals.astype(np.float32), affine)
    save_nifti(evecsname, evecs.astype(np.float32), affine)
    # save_nifti(ganame, ga.astype(np.float32), affine)
    # save_nifti(linname, linearity.astype(np.float32), affine)

    eng = matlab.engine.start_matlab()
    eng.dipyhelperdti(output, nargout=0)
    eng.exit()


def calc_dki(base, output, gtab, data, mask, affine):
    dkimodel = dki.DiffusionKurtosisModel(gtab)  # can add "fit_method='restore'" after gtab for REKINDLE?
    dkifit = dkimodel.fit(data, mask=mask)

    save_dki_outputs(dkifit, output, affine)


def calc_dti(base, output, gtab, data, mask, affine):
    tenmodel = dti.TensorModel(gtab)
    tenfit = tenmodel.fit(data, mask=mask)

    save_dti_outputs(tenfit, output, affine)


def process_data(data, bvals):
    print('Starting Gibbs Unringing\n')
    gibbs_removal(data)  # can also return new array instead of replacing by using 'inplace=False' as 2nd arg
    print('Done with Gibbs!\n')

    # denoised_data = mppca(data, patch_radius=2)  # change radius based on data
    data = patch2self(data, bvals, model='ols', b0_threshold=50)
    print('Done with Patch denoising\n')
    return data


def run_dipy(base, output, runtype, is_processed=True):
    # can pass runtype as '' to only run preprocessing on data, no fitting
    if not os.path.exists(output):
        os.makedirs(output)

    print(is_processed)

    # fname = '/dkiR276'
    fraw = base + '/dki2_withb0.nii'
    fbval = base + '/processed_data/topupped.bval'
    fbvec = base + '/processed_data/topupped.bvec'

    data, affine = load_nifti(fraw)
    bvals, bvecs = read_bvals_bvecs(fbval, fbvec)
    gtab = gradient_table(bvals, bvecs)

    # seg = base + '/mask.nii'
    # #
    # mask = nib.load(seg)
    # mask = np.array(mask.dataobj)

    mask = np.ones(data.shape[:-1])  # useful if you only want to run preprocessing, comment out lines above

    data = np.multiply(data, np.repeat(mask[:, :, :, np.newaxis], data.shape[3],
                                       axis=3))  # masked data, comment out if you don't want to mask

    # potential auto mask for brain data
    # maskdata, mask = median_otsu(data, vol_idx=range(5), median_radius=3, numpass=4, autocrop=False)

    # maskname = output + '/masked_data.nii.gz'
    # save_nifti(maskname, maskdata.astype(np.float32), affine)

    print('Finished reading Data in\n')

    if not is_processed:
        print('Data not processed')
        data = process_data(data, bvals)
        # data = mppca(data, patch_radius=4)
        # data = patch2self(data, bvals, model='ols', b0_threshold=50)  # for testing, otherwise use process_data to also do

        processed_data_name = output + '/processed_data.nii.gz'
        save_nifti(processed_data_name, data.astype(np.float32), affine)
        print('Saved data to ' + processed_data_name)

    if runtype == 'dti' or runtype == 'both':
        calc_dti(base, output, gtab, data, mask, affine)
    if runtype == 'dki' or runtype == 'both':
        calc_dki(base, output, gtab, data, mask, affine)
