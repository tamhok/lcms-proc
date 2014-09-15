library(xlsx)
source("~/hht_dataproc/R/hht_dataproc.R")

load.file  <- function(filename) {
	read.csv(filename, header=TRUE) 
}

load.files  <- function() {
	files = list.files(
		"~/Dropbox/MELTON CELL MANUSCRIPT DATA/FIles to plot for heat map/", 
		   pattern = "csv")
}
