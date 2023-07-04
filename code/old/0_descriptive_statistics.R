###0. packages
library(readxl)
library(ggplot2)
library(rlang)
library(psych)


##I. read data
getwd()
#setwd("~/Documents/GitHub/P2P-Model-Bondora")
#setwd("~/Users/bal8/Desktop")
#Change your work dictionary to this folder. In this script, we use relative file paths to facilitate collaboration among everyone.
data<-read.csv("data/sample_10k.txt",sep=",",header=T)
#data<-read.csv("P2P-Model-Bondora/data/sample_10k.txt",sep=",",header=T)
discription<-read_excel("P2P-Model-Bondora/data description/Description.xlsx",sheet="Sheet1")

##II. basic information about the dataframe
head(data)
colnames(data)
discription
data[1,]
dim(data)
table(data$default)

#histogram for each variable
for (i in 2:162) {
  # Get the feature name
  feature_name <- colnames(data)[i]
  
  # Calculate the minimum and maximum values for the feature
  min_value <- min(data[[i]], na.rm = TRUE)
  max_value <- max(data[[i]], na.rm = TRUE)
  
  # Create a histogram using ggplot2
  histogram_plot <- ggplot(data, aes(x = .data[[feature_name]])) +
    geom_histogram(binwidth = 0.2, color = "black", fill = "lightblue") +
    labs(title = paste("Histogram of", feature_name),
         subtitle = paste("Min:", min_value, "Max:", max_value),
         x = "Feature Value", y = "Count") +
    theme_minimal() +
    theme(plot.title = element_text(face = "bold", size = rel(1.2)),
          plot.subtitle = element_text(size = rel(1.1)))
  
  # Display the histogram
  print(histogram_plot)
}

#save as pdf
#always 200 breaks

##III. difference between two groups
for (i in 2:162) {
  # Get the feature name
  feature_name <- colnames(data)[i]
  
  # Calculate the minimum and maximum values for the feature
  min_value <- min(data[[i]], na.rm = TRUE)
  max_value <- max(data[[i]], na.rm = TRUE)
  
  # Create a histogram using ggplot2
  histogram_plot <- ggplot(data, aes(x = .data[[feature_name]], fill = factor(data[,1]))) +
    geom_histogram(binwidth = 0.2, color = "black", position = "identity", alpha = 0.5) +
    labs(title = paste("Histogram of", feature_name),
         subtitle = paste("Min:", min_value, "Max:", max_value),
         x = "Feature Value", y = "Count", fill = colnames(data)[1]) +
    theme_minimal() +
    theme(plot.title = element_text(face = "bold", size = rel(1.2)),
          plot.subtitle = element_text(size = rel(1.1)))
  
  # Display the histogram
  print(histogram_plot)
}

grouping_column_name <- colnames(data)[1]

# Loop through columns 2 to 162
for (i in 2:162) {
  # Get the feature name
  feature_name <- colnames(data)[i]
  
  # Calculate the minimum and maximum values for the feature
  min_value <- min(data[[i]], na.rm = TRUE)
  max_value <- max(data[[i]], na.rm = TRUE)
  
  # Create a histogram using ggplot2
  histogram_plot <- ggplot(data, aes(x = .data[[feature_name]], fill = factor(.data[[grouping_column_name]]))) +
    geom_histogram(binwidth = 0.2, color = "black", position = "identity", alpha = 0.5) +
    labs(title = paste("Histogram of", feature_name),
         subtitle = paste("Min:", min_value, "Max:", max_value),
         x = "Feature Value", y = "Count", fill = grouping_column_name) +
    theme_minimal() +
    theme(plot.title = element_text(face = "bold", size = rel(1.2)),
          plot.subtitle = element_text(size = rel(1.1)))
  
  # Display the histogram
  print(histogram_plot)
}

# descriptive statistic metrics
descriptive_stats = describe(data)





