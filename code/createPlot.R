plotBridgeCounts <- function(df){
  require(ggplot2)
  first <- TRUE
  for (bridgeName in df$Bridge) {
    if (first) {
      first <- FALSE
      plot(Count ~ Year, data = subset(df, Bridge = bridgeName))
    }else{
      points(Count ~ Year, data = subset(df, Bridge = bridgeName))
    }
  }
  
  
}
