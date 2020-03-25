retrieve_data <- function(url, target.folder) {
  
  # Download file and unzip to data
  # 
  # Args:
  #  url (str): URL to getting data zip file
  #  target.folder (str): Path to data
  #
  
  # Download and Unzip
  temp.file <- tempfile()
  download.file(url, temp.file)
  unzip(temp.file, exdir = target.folder)
  file.remove(temp.file)
  
}


read_data <- function(target.folder) {
  
  # Read data from text file returning relevant rows
  #
  # Args:
  #  target.folder (str): Path to data
  #
  # Returns:
  #  df (data.table): data with relevant rows
  
  # Read file
  df <- read.table(file.path(target.folder, 'household_power_consumption.txt'),
                   header=TRUE,
                   sep= ";",
                   na.strings = c("?",""))
  
  # Filter required periods
  df <- dplyr::filter(df, Date == "1/2/2007" | Date == "2/2/2007")
  
  # Convert time/date columns
  df <- dplyr::mutate(df,
                      Date = as.Date(Date, format = "%d/%m/%Y"),
                      Time = as.POSIXct(paste(Date, Time), format = "%Y-%m-%d %H:%M:%S"))

  return(df)
}


load_data <- function(url, target.folder, force.reload = FALSE) {
  
  # Load data set for plotting.  Combination of downloading and reading data.
  #
  # Args:
  #  url (str): URL to getting data zip file
  #  target.folder (str): Path to data
  #  force.reload (bool): Whether or not to force a reloading of the data.
  #                       If FALSE, and data is already available, then cached data will be loaded.
  #                       If TRUE, data will always be read from sources.
  #
  # Returns:
  #  df (data.table): data with relevant rows
  
  # Download Data if not already downloaded
  if (!dir.exists(target.folder)) {
    retrieve_data(url, target.folder)
  }
  
  if (force.reload | ! exists("loaded.df")) {
    # Read data
    df <- read_data(target.folder)
    loaded.df <<- df  # Save to global variable
    
  } else {
    df <- loaded.df   # Load from global variable
  }
  
  return (df)
}
