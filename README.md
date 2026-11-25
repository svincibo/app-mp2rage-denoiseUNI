<h1 align="center">Denoise MP2RAGE UNI</h1>

<p align="center">
  Denoises the UNI image of a Siemens MP2RAGE acquisition by robust combination with the two inversion images (Marques MP2RAGE scripts, compiled MATLAB), with a user-given or automatically selected regularisation parameter.
</p>

<p align="center">
  <a href="https://github.com/brainlife/abcd-spec"><img src="https://img.shields.io/badge/ABCD_Spec-v1.1-green.svg" alt="ABCD Spec v1.1"></a>
  <a href="https://doi.org/10.25663/brainlife.app.506"><img src="https://img.shields.io/badge/Brainlife-brainlife.app.506-blue.svg" alt="Run on brainlife.io"></a>
</p>

## At a glance

<!-- brainlife-app:begin (generated from the App manifest; edit the manifest, not this block) -->

> **Denoises the UNI image of a Siemens MP2RAGE acquisition by robust combination with the two inversion images (Marques MP2RAGE scripts, compiled MATLAB), with a user-given or automatically selected regularisation parameter.**

Applies the RobustCombination background-noise suppression of O'Brien/Marques to the MP2RAGE UNI image using the INV1 and INV2 magnitude images. If reg_param is left empty, the App tries a range of values (1 to 96) within a brain mask (user-provided, or made with FSL robustfov and bet) and picks the one where the brain intensities stop changing, using acquisition parameters from the image metadata. Use it before computing T1 and R1 maps (app-mp2rage-calculateT1andR1). Only Siemens MP2RAGE data are supported.

| | |
|---|---|
| **Inputs** | `neuro/anat/mp2rage` · `neuro/mask` (optional) |
| **Outputs** | `neuro/anat/mp2rage` |
| **Container** | `brainlife/fsl:5.0.9` |
| **Resources** | 1 CPUs |
| **Run it** | [doi.org/10.25663/brainlife.app.506](https://doi.org/10.25663/brainlife.app.506) |

#### Inputs

| Input | Datatype | Required | Description |
|---|---|---|---|
| `neuro/anat/mp2rage` | `neuro/anat/mp2rage` | yes | Siemens MP2RAGE dataset: INV1 and INV2 magnitude images, the UNI image and their JSON sidecars. For automatic parameter selection the sidecars need MagneticFieldStrength, RepetitionTime, InversionTime, BaseResolution, PercentPhaseFOV, PartialFourier and FlipAngle. |
| `neuro/mask` | `neuro/mask` | no | Optional brain mask used when selecting the regularisation parameter; otherwise one is made with FSL bet. Must have the same dimensions as the UNI image. |

#### Outputs

| Output | Datatype | Description |
|---|---|---|
| `output` | `neuro/anat/mp2rage` | UNI image with noise removed, for use in estimating T1 and R1 values |

<details>
<summary><b>Parameters</b> (2)</summary>

| Parameter | Type | Default | Description |
|---|---|---|---|
| `reg_param` | string | `16` | The regularization parameter that is best for your dataset depends on several factors. If you are not sure what regularization parameter to select, leave this field blank and we will select the best parameter for your dataset. |
| `slicesperslab` | number |  | Slices Per Slab should be available in the MRI sequence protocol. It is not always available in the image's header information. If you are sure that Slices Per Slab is available in the image's header information, you can leave this blank and we will get the value from there. Otherwise, please look up this value in the MRI sequence protocol and enter it here. |

</details>

<!-- brainlife-app:end -->

## Running the App

### On brainlife.io

Open the App at [doi.org/10.25663/brainlife.app.506](https://doi.org/10.25663/brainlife.app.506), choose `neuro/anat/mp2rage`, `neuro/mask` from your project, set the parameters and press **Execute**. The results are saved to your project as `neuro/anat/mp2rage`.

### Locally

You need [Singularity/Apptainer](https://apptainer.org/) (the App runs in `brainlife/fsl:5.0.9`), [`jq`](https://jqlang.github.io/jq/).

1. Clone this repository.
2. Create `config.json` with the paths to your inputs and the parameters:

   ```json
   {
       "mag_inv1": "/path/to/neuro/anat/mp2rage/mag_inv1",
       "mag_inv2": "/path/to/neuro/anat/mp2rage/mag_inv2",
       "unit1": "/path/to/neuro/anat/mp2rage/unit1",
       "json_inv1": "/path/to/neuro/anat/mp2rage/json_inv1",
       "json_inv2": "/path/to/neuro/anat/mp2rage/json_inv2",
       "json_unit1": "/path/to/neuro/anat/mp2rage/json_unit1",
       "mask": "/path/to/neuro/mask/mask",
       "reg_param": "16",
       "slicesperslab": "<number>"
   }
   ```

3. Run `./main`.

## Troubleshooting

- **mp2rage_denoiseUNI.m didn't produce a denoised unit1.nii.gz file**: Check the log for the MATLAB error.
- **Your mask must have the same dimensions as your UNI image. Please check that the mask and mp2rage data are aligned.**: Provide a mask in the UNI image grid, or omit it.
- **Sorry -- this app is not yet able to determine the SlicesPerSlab parameter from your metadata.**: Enter slicesperslab from the MRI protocol, or give reg_param.

## MP2RAGE Citations

Caan, M. W. A., Bazin, P.-L., Marques, J. P., de Hollander, G., Dumoulin, S. O., & van der Zwaag, W. (2019). MP2RAGEME: T1 , T2* , and QSM mapping in one sequence at 7 tesla. Human Brain Mapping, 40(6), 1786–1798.

Marques, J. P., & Gruetter, R. (2013). New Developments and Applications of the MP2RAGE Sequence-Focusing the Contrast and High Spatial Resolution R 1 Mapping. PloS One. https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0069294

Marques, J. P., & Gruetter, R. (2013). New developments and applications of the MP2RAGE sequence--focusing the contrast and high spatial resolution R1 mapping. PloS One, 8(7), e69294.

Marques, J. P., Kober, T., Krueger, G., van der Zwaag, W., Van de Moortele, P.-F., & Gruetter, R. (2010). MP2RAGE, a self bias-field corrected sequence for improved segmentation and T1-mapping at high field. NeuroImage, 49(2), 1271–1281.

## Citing

If you use this App, please cite it, the software it builds on and brainlife.io:

- Denoise MP2RAGE UNI. brainlife.io App. [doi:10.25663/brainlife.app.506](https://doi.org/10.25663/brainlife.app.506)
- Marques J. P., Kober T., Krueger G., van der Zwaag W., Van de Moortele P.-F., Gruetter R. MP2RAGE, a self bias-field corrected sequence for improved segmentation and T1-mapping at high field. NeuroImage 49(2):1271-1281 (2010).
- Marques J. P., Gruetter R. New developments and applications of the MP2RAGE sequence - focusing the contrast and high spatial resolution R1 mapping. PLoS One 8(7):e69294 (2013).
- Jenkinson et al. FSL. *NeuroImage* 62:782-790 (2012). [doi:10.1016/j.neuroimage.2011.09.015](https://doi.org/10.1016/j.neuroimage.2011.09.015)
- Hayashi S, Caron BA, Heinsfeld AS, et al. brainlife.io: a decentralized and open-source cloud platform to support neuroscience research. *Nature Methods* 21:809–813 (2024). [doi:10.1038/s41592-024-02237-2](https://doi.org/10.1038/s41592-024-02237-2)
- Avesani P, McPherson B, Hayashi S, et al. The open diffusion data derivatives, brain data upcycling via integrated publishing of derivatives and reproducible open cloud services. *Scientific Data* 6:69 (2019). [doi:10.1038/s41597-019-0073-y](https://doi.org/10.1038/s41597-019-0073-y)

## Authors

- Sophia Vinci-Booher

Code was adapted for brainlife.io; original version of this code can be found here: 
https://github.com/JosePMarques/MP2RAGE-related-scripts

**Project director**

- Franco Pestilli

## Funding

[![Wellcome-226486/Z/22/Z](https://img.shields.io/badge/Wellcome-226486%2FZ%2F22%2FZ-purple.svg)](https://wellcome.org/)
[![NIH-NINDS-U24NS140384](https://img.shields.io/badge/NIH_NINDS-U24NS140384-green.svg)](https://reporter.nih.gov/project-details/11261037)
[![NIH-NINDS-UM1NS132207](https://img.shields.io/badge/NIH_NINDS-UM1NS132207-green.svg)](https://reporter.nih.gov/project-details/11411328)
[![NIH-NIBIB-R01EB029272](https://img.shields.io/badge/NIH_NIBIB-R01EB029272-green.svg)](https://reporter.nih.gov/project-details/10262925)
[![NIH-NIBIB-R01EB030896](https://img.shields.io/badge/NIH_NIBIB-R01EB030896-green.svg)](https://reporter.nih.gov/project-details/10428625)
[![NIH-NIMH-R01MH126699](https://img.shields.io/badge/NIH_NIMH-R01MH126699-green.svg)](https://reporter.nih.gov/project-details/10460628)
[![NIH-NIDCD-R01DC020088](https://img.shields.io/badge/NIH_NIDCD-R01DC020088-green.svg)](https://reporter.nih.gov/project-details/11140284)
[![NSF-BCS-1734853](https://img.shields.io/badge/NSF_BCS-1734853-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=1734853)
[![NSF-BCS-2203524](https://img.shields.io/badge/NSF_BCS-2203524-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=2203524)
[![NSF-IIS-1636893](https://img.shields.io/badge/NSF_IIS-1636893-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=1636893)
[![NSF-OAC-2148729](https://img.shields.io/badge/NSF_OAC-2148729-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=2148729)
[![NSF-IIS-1912270](https://img.shields.io/badge/NSF_IIS-1912270-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=1912270)
[![NSF-IIS-2148700](https://img.shields.io/badge/NSF_IIS-2148700-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=2148700)
[![NSF-OAC-1916518](https://img.shields.io/badge/NSF_OAC-1916518-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=1916518)

<sub>brainlife.io, which runs this App, is publicly funded by Wellcome, the U.S. National Institutes of Health and the U.S. National Science Foundation; acknowledging that support helps keep it running.</sub>
