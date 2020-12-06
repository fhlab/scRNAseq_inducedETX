# scRNAseq inducedETX (iETX) data processing
This is the GitHub repository describing the scRNA-seq analysis carried out for the publication: "Inducible stem cell-derived embryos capture mouse morphogenetic events *in vitro*", Amadei et al. Developmental Cell 2020 (Figure 7 and Supplementary Figure 7). Please visit the Gene Expression Omnibus  [GSE161947](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE161947) entry to find raw and processed datasets.

**1. Pre-processing the data**

Note: the steps can be concatenated in master scripts if automation is needed, the files presented here are intended to be showcased for each step separately.

**a) bcl2fastq conversion**

The BCL files were converted fastq files using the bcl2fastq.sh script.

**b) De-multiplexing using the Pheniqs tool from [biosails/pheniqs](https://github.com/biosails/pheniqs)**

The run_pheniqs.sh script was used to de-multiplex the fastq files according the run_pheniqs.json json file. The data posted on GSE161947 is already de-multiplexed and corresponds to the data obtained after this step.

**c) Running zUMIs to produce count matrices**

The [zUMIs pipeline](https://github.com/sdparekh/zUMIs) was ran using the script run_zumis.sh for each of the samples. To convert the resulting produced dgecounts.rds files to txt matrices counting both intronic and exonic UMI counts using the extract_inex_matrix.R file
