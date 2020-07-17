library(xlsx)
library(GNAR)
library(igraph)
library(xts)
library(fields)

setwd("/home/james/miniProject2")

# -------------------------------- Read files

files <- list.files(path = "CPI", pattern="*.xlsx", full.names = TRUE, recursive=FALSE)

data <- read.xlsx("CPI/Argentina.xlsx", sheetName = "Sheet1", startRow = 2)
row.names(data) <- data[,1] # Set first column as row names
data <- data[,-1] 
for (file in files[-1]) # Already included Argentina
{
  newData <- read.xlsx(file, sheetName = "Sheet1", startRow = 2)
  newData <- newData[,-1] # Remove date column 
  data <- cbind(data, newData)
}

# Convert to multiple time series
tsData <- xts(data, order.by = as.Date(row.names(data)), names = colnames(data))
tsData <- tsData[1:(dim(tsData)[1]),]


# --------------------------------- Setting up test conditions

net1 <- seedToNet(seed.no = seedNo, nnodes = dim(tsData)[2], graph.prob = 0.15)



# Compute residuals for GNAR(2,[1,1]) without global parameters



