#args <- commandArgs(trailingOnly = TRUE)

source("code/load_data.r")

dataPath <- "data/Hawthorne Tilikum Steel daily bike counts 073118.xlsx"
allData <- loadAllDataLong(dataPath)
allData <- allData[complete.cases(allData),]

# create groupings
byBridge <- group_by(allData,Bridge)
byBridgeDate <- group_by(allData,Bridge,date)
byBridgeYear <- group_by(allData,Bridge,Year)
byBridgeMonth <- group_by(allData,Bridge,Month)
byBridgeYearMonth <- group_by(allData,Bridge,Year,Month)
byYearMonth <- group_by(allData,Year,Month)
byYear <- group_by(allData,Year)

#Days of data for each bridge
print("number of days with data by bridge")
summarise(byBridge, n_distinct(date))

# avg, min, and max for each bridge
print("average count of bicycles by bridge")
summarise(byBridge, sum(Count)/n_distinct(date))
print("")
print("minimum count of bicycles by bridge")
summarise(byBridgeDate, sum(Count)) %>% group_by(.,Bridge) %>% summarise(.,min(`sum(Count)`))
print("")
print("maximum count of bicycles by bridge")
summarise(byBridgeDate, sum(Count)) %>% group_by(.,Bridge) %>% summarise(.,max(`sum(Count)`))

# average monthly counts
summarise(byBridgeMonth, sum(Count)/n_distinct(date))

# average yearly Counts
summarise(byBridgeYear, sum(Count)/n_distinct(date))

# monthly aggregates
(tmp <- summarise(byBridgeYearMonth, sum(Count)))
#summarise(byBridgeMonth, sum(Count)/n_distinct(date))

#plot(tmp)
