##
## Sanity checks for gene expression changes ... Look at the reported raw levels of gene expression.

load("fdr.RData")

source("readData.R")

rpkm_df <- as.matrix(ca[,indx.good[c(2:9,11:17)]]) ## "Good?!"  Remove H2-U, H3-PI, C2-U+PI, M1-PI
for(i in 1:NCOL(rpkm_df)) rpkm_df[,i] <- log(1000*(rpkm_df[,i]+0.25)/sum(rpkm_df[,i]) *1000/(ca[,"mapSize"]))

source("../lib/circplot.R")
snU <- c(rep("H-U",3), rep("C-U", 2), rep("M-U",3), rep("H-PI", 3), rep("C-PI", 2), rep("M-PI", 2))

## Write out all human
hc <- fdr_df[fdr_df$HumanFDR < 0.05,][order(fdr_df$HumanFDR[fdr_df$HumanFDR < 0.05]),]
hcn<- as.character$name(fdr_df[fdr_df$HumanFDR < 0.05][order(fdr_df$HumanFDR[fdr_df$HumanFDR < 0.05])])
pdf("circPlot.hc.pdf")
for(n in hcn) {
  cd.circplot(rpkm_df[ca$name == n, ], snU)
}
dev.off()

## Specific examples...
q("no")

## Good ...
cd.circplot(rpkm_df[ca$name == "chr12_15771150_15943000", ], snU)
cd.circplot(rpkm_df[ca$name == "chr13_77989450_77990050", ], snU)
cd.circplot(rpkm_df[ca$name == "chr12_6308800_6352600", ], snU) ## CD9.  Quite clear.
cd.circplot(rpkm_df[ca$name == "chr12_2173350_2176350", ], snU)
cd.circplot(rpkm_df[ca$name == "chr5_140005300_140013300", ], snU) ## CD14.  Might be biased, but looks right on all accounts.


## Not a clean case on the browser, but looks good from availiable data.
cd.circplot(rpkm_df[ca$name == "chr14_104327650_104338350", ], snU)
cd.circplot(rpkm_df[ca$name == "chr12_8230900_8235450", ], snU)
cd.circplot(rpkm_df[ca$name == "chr6_34393250_34394100", ], snU)

## Not sure...
cd.circplot(rpkm_df[ca$name == "chrY_1523573_1606700", ], snU) ## H and M clearly both outlier species.  This one's the setup.
cd.circplot(rpkm_df[ca$name == "chr6_41301800_41302500", ], snU) ## H and C are pretty similar... H higher, but not by much.
cd.circplot(rpkm_df[ca$name == "chr6_36879950_36880650", ], snU) ## Again, H and C pretty similar ... Again H clearly higher.

## Bad...
cd.circplot(rpkm_df[ca$name == "chr17_38776650_38777400", ], snU) ## Extra chimp might help?!

## Untested


## IL2RA
cd.circplot(rpkm_df[ca$name == "chr10_6041300_6104350", ][1,], snU)

## IL2RA-enhancer
cd.circplot(rpkm_df[ca$name == "chr10_6079150_6108800", ], snU) 

## MALT1
cd.circplot(rpkm_df[ca$name == "chr18_56338250_56435300", ], snU) 