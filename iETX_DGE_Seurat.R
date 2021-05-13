library(Seurat)
library(patchwork)
library(SeuratDisk)
library(dplyr)
library(EnhancedVolcano)
library(ggplot2)


setwd("PATH")

# Import the data
rm <- read.table("iETX_cat_R.csv", sep = ',', header = T, row.names=1,as.is = T)

obj <- CreateSeuratObject(counts = rm , min.cells = 3, assay = "RNA",names.field = 2,
                           names.delim = ".",
                           project = "iETX_proj")
                           
# Normalize, find the variable features, scale and perform dimensional reduction
obj[["percent.mt"]] <- PercentageFeatureSet(object = obj, pattern = "^mt-")
obj  <- NormalizeData(object = obj ) #not needed if you load the raw normalized object from scanpy
obj <- FindVariableFeatures(object = obj, selection.method = "vst", nfeatures = 2000)
obj<- ScaleData(object = obj, vars.to.regress = c("percent.mt"))
obj <- RunPCA(object = obj, features = VariableFeatures(object = obj))
obj <- RunUMAP(object = obj,reduction = "pca", dims = 1:21, n_neighbors=100, min_dist = 1) %>% FindNeighbors(reduction = "pca", dims = 1:21) %>% FindClusters(resolution = 0.5) %>% identity() 
DimPlot(obj)

# Load the annotations
data <- read.csv("iETX_cell_type_annotation.csv", header=TRUE)
Idents(obj) <- data$annot

# Perform DGE
all_diff<- FindMarkers(object = obj, ident.1 =  "Primitive streak iETX", ident.2 = "Primitive streak E6.5", logfc.threshold = 0.001, min.pct = 0.001)

# Export DGEs
write.csv(all_diff ,  file = "Primitive streak iETXvsPrimitive streak E6.5.csv",row.names=TRUE)
