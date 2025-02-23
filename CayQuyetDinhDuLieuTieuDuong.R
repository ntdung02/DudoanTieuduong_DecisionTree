# 1.Load dữ liệu huấn luyện của bệnh tiểu đường từ file diabetes.csv lên phần mềm

mydata <-read.csv("C:/Users/Vinh/Downloads/diabetes.csv")
mydata


#xem thông tin dữ liệu
#xem 6 dòng đầu tiên
head(mydata)

# tóm tắt thông số thống kê
summary(mydata) 

# kiểm tra kiểu dữ liệu
str(mydata)

# chuyển đối các biến đầu vào thành kiểu số và kiểu fator nếu cần 
mydata$preg <- as.numeric(mydata$preg)
mydata$plas <- as.numeric(mydata$plas)
mydata$pres<- as.numeric(mydata$pres)
mydata$skin <- as.numeric(mydata$skin)
mydata$insu <- as.numeric(mydata$insu)
mydata$mass <- as.numeric(mydata$mass)
mydata$pedi <- as.numeric(mydata$pedi)
mydata$age <- as.numeric(mydata$age)

# Lọc - xoá các giá trị bị thiếu
mydata <- na.omit(mydata)

# Chia tập dữ liệu thành tập huấn luyện và tập kiểm tra : 7-3 
set.seed(123)
trainIndex <- sample(1:nrow(mydata), 0.7*nrow(mydata))
trainData <- mydata[trainIndex, ]
testData <- mydata[-trainIndex, ]

# 2. Sử dụng hàm rpart để xây dựng cây quyết định
install.packages("rpart")
library(rpart)
model <- rpart(KetLuan ~ preg + plas + pres + skin + insu +
                 mass + pedi + age, data = trainData, method = "class")


# vẽ cây quyết định bằng hàm rpart.plot
install.packages("rpart.plot")
library(rpart.plot)
rpart.plot(model, type = 3, extra = 1,  clip.right.labs = FALSE, cex = 0.6)



plot(mydata)

# 3. Dùng table để tính ma trận nhầm lẫn và độ chính xác đối lập trên tập TestData


predicted <- predict(model, newdata=testData, type = "class")

confusionMatrix <- table(testData$KetLuan, predicted)
accuracy <- sum(diag(confusionMatrix))/sum(confusionMatrix)
print(confusionMatrix)
print(paste0("Accuracy: ", accuracy))

# 4. Áp dụng cho mô hình dự báo bệnh tiểu đường
# Load dữ liệu dữ báo từ file diabetes_predict.csv
predict_data <-read.csv("C:/Users/Vinh/Downloads/diabetes_predict.csv")
predict_data


# TIến hành phân lớp cho kết quả
new_predict <- predict(model, newdata=predict_data, type = "class")
print (new_predict)




