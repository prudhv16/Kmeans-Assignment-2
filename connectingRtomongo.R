#library(devtools)
#install_github(repo = "mongosoup/rmongodb")
library(rmongodb)
# connect to MongoDB
mongo = mongo.create(host = "localhost")
mongo.is.connected(mongo)
DBNS = "Datamining.rawdata"
mongo.count(mongo, ns = DBNS)
find_all = mongo.find.all(mongo, ns = DBNS)
library(plyr)
## create the empty data frame
BreastCancerdata = data.frame(stringsAsFactors = FALSE)

cursor = mongo.find(mongo, DBNS)

## create the counter
i = 1

## iterate over the cursor
while (mongo.cursor.next(cursor)) {
  # iterate and grab the next record
  tmp = mongo.bson.to.list(mongo.cursor.value(cursor))
  # make it a dataframe
  tmp.df = as.data.frame(t(unlist(tmp)), stringsAsFactors = F)
  # bind to the master dataframe
  BreastCancerdata = rbind.fill(BreastCancerdata, tmp.df)
  # to print a message, uncomment the next 2 lines cat('finished game ', i,
  # '\n') i = i +1
}
BreastCancerdata = as.data.frame(BreastCancerdata)
BreastCancerdata1 = BreastCancerdata[,3:12]
#BreastCancerdata1 = as.data.frame(BreastCancerdata1)
