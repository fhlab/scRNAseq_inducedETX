#!/bin/bash


STAR   --runMode genomeGenerate   --runThreadN 10   --genomeDir STAR_MM99   --genomeFastaFiles  Mus_musculus.GRCm38.dna.primary_assembly.fa  --limitGenomeGenerateRAM 50000000000     --genomeSAindexNbases 14   --genomeChrBinNbits 18   --genomeSAsparseD 9
