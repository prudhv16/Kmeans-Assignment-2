#BreastCancerdata <- read.csv("breast-cancer-wisconsin.data")
tempBreastCancerdata = BreastCancerdata[grep('[[:punct:]]',BreastCancerdata[,8]),]["Sample code number"]

BreastCancerdata1 = as.data.frame(apply(BreastCancerdata1,2,function(x) as.integer(x)))
#NoofPeopleHavingBreastCancer = BreastCancerdata1["Class"] = 4

noofMissingValues = sum(is.na(BreastCancerdata1))
print (noofMissingValues)
nopatientshavingmissingdata = sum(apply(BreastCancerdata1,2,function(x) is.na(x)))
print (nopatientshavingmissingdata)
SCNofpatientsHavingMissingData = BreastCancerdata[grep('[[:punct:]]',BreastCancerdata[,8]),]["Sample code number"]

