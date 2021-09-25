library(readr)

# Read dataset as comma separated value
DataSet <- read_csv(<PATH>.csv")
View(DataSet)

# Sort dataset by timestamp
dsIdx<-order(DataSet$`@timestamp`)
dsSort<-DataSet[dsIdx,]

# Remove NA values manually (See "na.rm = TRUE")
dsClean<-dsSort$column[-c(1,2)]

# Select interval for a consistent dataset (if multiple data sources are used)
dsClean = dsClean[1:360]

# Calculate mean
dsMean = mean(dsClean)

# Prepare string above line
paste("Mean:",sprintf(dsMean, fmt = '%#.2f'))->MeanValueStringDS

# Plot graph
plot(dsClean, xlab="Measurement file index", ylab="Execution time (s)", main="Execution times with measurement data from BSC Kirchberg")
abline(h=dsMean, col="blue", lwd=2)
text(dsMean+16,dsMean,MeanValueStringDS,srt=0.2,pos=3,col = "blue")
