##Document for H2O:
#https://docs.h2o.ai/h2o/latest-stable/h2o-docs/automl.html




install.packages("h2o")
library(h2o)
h2o.init()

#An example
# 初始化H2O集群
h2o.init()
# 下载鸢尾花数据集
url <- "https://archive.ics.uci.edu/ml/machine-learning-databases/iris/iris.data"
iris_data <- read.csv(url, header = FALSE)

# 为数据集的列添加列名
colnames(iris_data) <- c("sepal_length", "sepal_width", "petal_length", "petal_width", "species")

# 将数据转换为H2O可处理的格式
iris_h2o <- as.h2o(iris_data)

# 指定要进行聚类的列
x <- c("sepal_length", "sepal_width", "petal_length", "petal_width")

# 使用H2O K-Means聚类算法
kmeans_model <- h2o.kmeans(training_frame = iris_h2o, x = x, k = 3, seed = 42)

# 显示模型结果
print(kmeans_model)

# 获取聚类标签
cluster_labels <- h2o.predict(kmeans_model, iris_h2o)

# 将H2OFrame转换为数据框
cluster_labels_df <- as.data.frame(cluster_labels)

# 将聚类标签添加到原始数据集
iris_data$cluster <- as.factor(cluster_labels_df$predict)

# 加载ggplot2包绘制聚类结果
library(ggplot2)

ggplot(iris_data, aes(x = sepal_length, y = sepal_width, color = cluster)) +
  geom_point(size = 2, alpha = 0.8) +
  theme_minimal() +
  labs(title = "鸢尾花聚类结果", x = "花萼长度", y = "花萼宽度")

# 关闭H2O集群
h2o.shutdown(prompt = FALSE)






