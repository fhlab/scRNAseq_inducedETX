# scRNAseq inducedETX (iETX) data processing
This is the GitHub repository describing the scRNA-seq analysis carried out for the publication: "Inducible stem cell-derived embryos capture mouse morphogenetic events *in vitro*", Amadei et al. Developmental Cell 2020 (Figure 7 and Supplementary Figure 7). Please visit the Gene Expression Omnibus [GSE161947](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE161947) entry to find raw and processed datasets. The Natural embryo at E4.5 dataset can be found at the Gene Expression Omnibus [GSE134240](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE134240) from a previous submission.

![alt text](https://github.com/fhlab/scRNAseq_inducedETX/blob/main/UMAP_iETX.png)

**1. Pre-processing the data**

Note: All the steps can be concatenated in master scripts if automation is needed, the files presented here are intended to be showcased for each step independently.

**a) Generating the STAR index**

The *Mus musculus* STAR indexing was ran using the [run_STAR_indexer.sh](https://github.com/fhlab/scRNAseq_inducedETX/blob/main/run_STAR_indexing.sh) script. 

**b) bcl2fastq conversion**

The BCL files were converted fastq files using the [bcl2fastq.sh](https://github.com/fhlab/scRNAseq_inducedETX/blob/main/bcl2fastq.sh) script.

**c) De-multiplexing using the Pheniqs tool from [biosails/pheniqs](https://github.com/biosails/pheniqs)**

The [run_pheniqs.sh](https://github.com/fhlab/scRNAseq_inducedETX/blob/main/run_pheniqs.sh) script was used to de-multiplex the fastq files according the [run_pheniqs.json](https://github.com/fhlab/scRNAseq_inducedETX/blob/main/run_pheniqs.json) json file. The data posted on GSE161947 is already de-multiplexed and corresponds to the data obtained after this step.

**d) Running zUMIs to produce count matrices**

The [zUMIs pipeline](https://github.com/sdparekh/zUMIs) was ran using the script [run_zumis.sh](https://github.com/fhlab/scRNAseq_inducedETX/blob/main/run_zumis.sh) for each of the samples. To convert the resulting produced dgecounts.rds files to txt matrices counting both intronic and exonic UMI counts using the [extract_inex_matrix.R](https://github.com/fhlab/scRNAseq_inducedETX/blob/main/extract_inex_matrix.R) file. The Ensembl names were then converted to gene names using the [convert_names.ipynb](https://github.com/fhlab/scRNAseq_inducedETX/blob/main/convert_names.ipynb) script.

**2. Data analysis**

**a) Filtering the data in [scanpy](https://github.com/theislab/scanpy)**

Scanpy was used to preprocess the data, along with the [Scrublet](https://github.com/AllonKleinLab/scrublet) package for doublet removal. This step eliminates the noise indtroduced by empty droplets, dead cells and cell doublets mainly and can be found in the Jupyter notebook [iETX_filter_the_data.ipynb](https://github.com/fhlab/scRNAseq_inducedETX/blob/main/iETX_filter_the_data.ipynb).

**b) Plotting the data**

The scripts for plotting from the h5ad object is the [iETX_plotting.ipynb](https://github.com/fhlab/scRNAseq_inducedETX/blob/main/iETX_plotting.ipynb) jupyter notebook.

**c) Perform differential gene expression (DGE) analysis with [Seurat](https://github.com/satijalab/seurat)**

The script for performing pairwise DGE analysis can be found in the [iETX_DGE_Seurat.R](https://github.com/fhlab/scRNAseq_inducedETX/blob/main/iETX_DGE_Seurat.R) file. It requires a conversion of the scanpy adata to a Seurat compatible matrix with the following command: pd.DataFrame(data=adata.raw.X.A, index=adata.obs_names, columns=adata.var_names).T.to_csv("iETX_cat_R.csv").

![alt text](https://github.com/fhlab/scRNAseq_inducedETX/blob/main/UMAP_markers.png)
