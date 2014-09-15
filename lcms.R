library(xlsx)
library(reshape)
source("~/hht_dataproc/R/hht_dataproc.R")

load.file  <- function(filename) {
	print(filename)
	data = read.csv(filename, header = FALSE, stringsAsFactors = FALSE) 
	headers = as.character(data[1,])
	#Figure out which columns are what acc = grep("Acc", headers)
	samples = grep("RZA|SLG", headers)
	acc = grep("Acc", headers)
	
	pdata = data[-1, c(acc, samples)]
	colnames(pdata) = data[1, c(acc, samples)]
	print(colnames(pdata))
	extras = data.frame(run = rep(basename(filename), nrow(pdata)))
	if(length(strsplit(colnames(pdata)[2], " ")[[1]]) == 3) {
		cnames = c("mat", "size",  "id")
		extras = data.frame(ie = rep(NA, nrow(pdata)), run = extras$run)
	} else {
		cnames = c("mat", "size", "ie", "id")
	}
	pdata = melt(pdata, id = 1)
	pdata = data.frame(value = pdata$value, acc = pdata[,1], 
		colsplit(pdata$variable, split = " ", names = cnames))
	return(cbind(pdata, extras))
}

load.files  <- function() {
	
	filebase = "~/Dropbox/MELTON CELL MANUSCRIPT DATA/FIles to plot for heat map/"
	files = list.files(filebase, pattern = "csv", full.names = TRUE)
	datas = lapply(files, load.file)  
	
	alldatas = Reduce(rbind, datas)
	alldatas$value = log(as.numeric(alldatas$value))
}

lcms.test  <-  function() {
	filename = "~/Dropbox/MELTON CELL MANUSCRIPT DATA/FIles to plot for heat map/140903_58_OV_sample1_123.csv"
}
