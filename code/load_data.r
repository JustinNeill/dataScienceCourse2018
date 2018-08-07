loadAllDataLong <- function(dataPath = "")
{
  library("readxl")
  library("dplyr")
  if (dataPath == "") {
    stop("Must provide the dataPath")
  }
  sheets <- excel_sheets(dataPath)
  
  outDF <- data.frame("date" = as.Date(character()),"Bridge" = character(),"Direction" = character(),"Count" = character())

  for (i in 1:length(sheets)) {
    tmpDF <- read_xlsx(dataPath,i,skip = 1)
    for (j in colnames(tmpDF)) {
      if (tolower(j) != "date" && tolower(j) != "total") {
        counts <- select(tmpDF,j)
        colnames(counts) <- "Count"
        if (grepl("west",tolower(j))) {
          direction = "westbound"
        }else if (grepl("east",tolower(j))) {
          direction = "eastbound"
        }else if (grepl("lower",tolower(j))) {
          direction = "river walk"
        }else if (grepl("total",tolower(j))) {
          direction = "total"
        }else {
          direction = "unknown"
          
        }
        outDF <-rbind(outDF, data.frame("date" = select(tmpDF,"date"), "Bridge" = sheets[i], "Direction" = direction, "Count" = counts))
      }
    }
  }
  #outDF$date <- as.Date(outDF$date , "%Y-%m-%d")
  outDF$Year <- format(outDF$date, "%Y")
  outDF$Month <- format(outDF$date, "%m")
  outDF$Day <- format(outDF$date, "%d")
  return(outDF)
}
