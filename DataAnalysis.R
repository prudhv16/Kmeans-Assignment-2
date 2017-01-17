##using BreastCancerdata1
Mode <- function(x) {
  uniquex <- unique(x)
  uniquex[which.max(tabulate(match(x, uniquex)))]
}

BreastCancerdata1 = as.data.frame(BreastCancerdata1)
BreastCancerdata1mean = apply(BreastCancerdata1,2,mean,na.rm=TRUE)
print (BreastCancerdata1mean)
BreastCancerdata1median = apply(BreastCancerdata1,2,median,na.rm=TRUE)
print (BreastCancerdata1median)

BreastCancerdata1mode = apply(BreastCancerdata1,2,Mode)
print (BreastCancerdata1mode)

#Variance 
print (var(as.matrix(BreastCancerdata1)))

#see and write 10 functions to plot histograms
#sapply(BreastCancerdata1, function(x) barplot(prop.table(table(x))))
hist(BreastCancerdata1$`Clump Thickness`,main="Clump thinkness histogram plot", xlab="Value",ylab="frequency")
hist(BreastCancerdata1$`Uniformity of Cell Size`,main="Uniformity of Cell Size histogram plot", xlab="Value",ylab="frequency")
hist(BreastCancerdata1$`Uniformity of Cell Shape`,main="Uniformity of Cell Shape histogram plot", xlab="Value",ylab="frequency")
hist(BreastCancerdata1$`Marginal Adhesion`,main="Marginal Adhesion histogram plot", xlab="Value",ylab="frequency")
hist(BreastCancerdata1$`Single Epithelial Cell Size`,main="Single Epithelial Cell Siz histogram plot", xlab="Value",ylab="frequency")
hist(BreastCancerdata1$`Bare Nuclei`,main="Bare Nuclei histogram plot", xlab="Value",ylab="frequency")
hist(BreastCancerdata1$`Bland Chromatin`,main="Bland Chromatin histogram plot", xlab="Value",ylab="frequency")
hist(BreastCancerdata1$`Normal Nucleoli`,main="Normal Nucleoli histogram plot", xlab="Value",ylab="frequency")
hist(BreastCancerdata1$Mitoses,main="Mitoses histogram plot", xlab="Value",ylab="frequency")
hist(BreastCancerdata1$Class,main="Class histogram plot", xlab="Value",ylab="frequency")
#cor.prob(BreastCancerdata1)

meanBreastCancerdata1 = BreastCancerdata1
#Replacing NA values with its mean in "Bare Nuclei" column
meanBreastCancerdata1$`Bare Nuclei`[is.na(meanBreastCancerdata1$`Bare Nuclei`)] = mean(BreastCancerdata1$`Bare Nuclei`,na.rm = TRUE)

#Removing one column in input data.
print (cor(as.matrix(meanBreastCancerdata1)))
#
meanBreastCancerdata1 <- meanBreastCancerdata1[ -c(2) ]
write.csv(meanBreastCancerdata1, file = "BreastCancerdatamean.csv")
