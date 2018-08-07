load_data <- function(dataPath = "", Name = NA,Number = NA)
{
  library("readxl")
  if (dataPath == "") {
    stop("Must provide the dataPath")
  }
  sheets <- excel_sheets(dataPath)
  if (!is.na(Name)) {
    if (Name %in% sheets) {
      return(read_xlsx(dataPath,Name,skip = 1))
    }else{
      error=stop("provided sheet name did not exist")
    }
  }else if (!is.na(Number)) {
    if (Number > 0 && Number <= length(sheets)) {
      return(read_xlsx(dataPath,Number,skip = 1))
    }else{
      error=stop("The sheet number is outside the range of sheets")
    }
  }else {
    stop("Need to specify the sheet Name or Number")
  }
}

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
