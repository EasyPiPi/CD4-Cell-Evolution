require(dREG)

load("/local/storage/data/dREG-Model/asvm.mammal.RData")

args <- commandArgs(trailingOnly=TRUE)
prefix   <- args[1]
pth      <- args[2]

## Read PRO-seq data.
gs_plus_path  <- paste(pth, prefix, c("-U_plus.bw","-PI_plus.bw"),sep="") #-U.bed.gz_plus.bw", "-PI.bed.gz_plus.bw"), sep="")
gs_minus_path <- paste(pth, prefix, c("-U_minus.bw","-PI_minus.bw"),sep="") #-U.bed.gz_minus.bw", "-PI.bed.gz_minus.bw"), sep="")

outnames <- paste(prefix, c("-U.TSS.bedGraph.gz", "-PI.TSS.bedGraph.gz"), sep="")

gdm <- genomic_data_model(window_sizes= c(10, 25, 50, 500, 5000), half_nWindows= c(10, 10, 30, 20, 20)) 

for(i in 1:length(gs_plus_path)) {
	## Now scan all positions in the genome ...
	inf_positions <- get_informative_positions(gs_plus_path[i], gs_minus_path[i], depth= 0, step=50, use_ANDOR=TRUE, use_OR=FALSE) ## Get informative positions.

	pred_val<- eval_reg_svm(gdm, asvm, inf_positions, gs_plus_path[i], gs_minus_path[i], batch_size= 50000, ncores=10)

	final_data <- data.frame(inf_positions, pred_val)
	options("scipen"=100, "digits"=4)
	write.table(final_data, file=pipe(paste("gzip -c > ",outnames[i])), row.names=FALSE, col.names=FALSE, quote=FALSE, sep="\t")
}
