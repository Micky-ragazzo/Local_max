peakdet_new <- function(dmx, v, x = NULL)
{
  maxtab <- NULL
  mintab <- NULL
  delta <-  .5 
  
  if (is.null(x))
  {
    x <- seq_along(v)
  }
  
  if (length(v) != length(x))
  {
    stop("Input vectors v and x must have the same length")
  }
  
  # if (!is.numeric(delta))
  # {
  #   stop("Input argument delta must be numeric")
  # }
  # 
  # if (delta <= 0)
  # {
  #   stop("Input argument delta must be positive")
  # }
  
  mn <- Inf
  mx <- -Inf
  
  mnpos <- NA
  mxpos <- NA
  
  lookformax <- TRUE
  
  for(i in seq_along(v))
  {
    this <- v[i]
    
    if (this > mx)
    {
      mx <- this
      mxpos <- x[i]
    }
    
    if (this < mn)
    {
      mn <- this
      mnpos <- x[i]
    }
    
    if (lookformax)
    {
      if (this < mx - delta)
      {
        maxtab <- rbind(maxtab, data.frame(pos = mxpos, val = mx))
        
        mn <- this
        mnpos <- x[i]
        
        lookformax <- FALSE
      }
    }
    else
    {
      if (this > mn + delta)
      {
        mintab <- rbind(mintab, data.frame(pos = mnpos, val = mn))
        
        mx <- this
        mxpos <- x[i]
        
        lookformax <- TRUE
      }
    }
  }
  
  if(nrow(data.frame(list(maxtab = maxtab)))== 1)
  {
    data.frame(DataMatrix=c(unique(dmx)), Status=c("OK"))
  } else
  {
    data.frame(DataMatrix=c(unique(dmx)), Status=c("NOK"))
  }
  #list(maxtab = maxtab) #,mintab = mintab)
  #return(maxtab)
  # if(nrow(data.frame(list(maxtab = maxtab)) >= 1))
  #        {
  #          return(print("NOK"))
  #        } else
  #          {
  #          return(print("OK"))
  #        }
  
}

# df_list <- by(DMX_together, DMX_together$DataMatrix, function(sub) 
#        peakdet_new(sub$DataMatrix, sub$X, sub$Y))
#  final_df <- do.call(rbind, unname(df_list))
# final_df
#write.xlsx(final_df, "../mydata.xlsx", sheetName = "Sheet1", col.names = TRUE, row.names = TRUE)
