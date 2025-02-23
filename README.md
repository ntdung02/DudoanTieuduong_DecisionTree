DudoanTieuduong_DecisionTree
# ỨNG DỤNG PHÂN LỚP CÂY QUYẾT ĐỊNH HỖ TRỢ CHẨN ĐOÁN CHẾ ĐỘ ĂN KIÊNG VÀ BỆNH TIỂU ĐƯỜNG

## 1. Giả thiết
**Một giả thiết được đặt ra** cho vấn đề kinh doanh rằng Bác sĩ T muốn mở thêm dịch vụ khám bệnh cho phòng khám của mình về bệnh tiểu đường. Vậy thì các câu hỏi được đặt ra là "Làm thế nào để dự đoán xác suất một khách hàng sẽ mắc bệnh tiểu đường?" hoặc  "Có mối quan hệ nào giữa đường huyết và bệnh tiểu đường không?". Sau cùng là đưa ra các giải pháp như thế nào cho việc phòng ngừa và chăm sóc sức khỏe khách hàng, ví dụ nếu một bệnh nhân mắc tiểu đường với xác suất cao thì phòng khám đề xuất cho việc thay đổi chế độ ăn uống hoặc tăng cường hoạt động thể chất để giảm nguy cơ mắc bệnh tiểu đường. 

Ngoài ra cái vấn đề về khai phá dữ liệu ở đây được hiểu là “Làm sao để biết được kết quả Dương tính hay Âm tính đối với bệnh tiểu đường?”, “Làm thế nào để dự đoán xác suất âm tính hay dương tính dựa trên các chỉ số lâm sàng?”

## 2. Giới thiệu dataset
Việc thu thập dữ liệu ở đây  dựa vào Bộ dữ liệu Pima Diabetes chứa thông tin về 768 bệnh nhân nữ từ dân tộc Pima và Maricopa ở Arizona, Mỹ có độ tuổi từ 21-81.  Được cung cấp bởi Weka, bộ dữ liệu này chứa các đặc trưng y tế của bệnh nhân như huyết áp, đường huyết, trọng lượng cơ thể, tuổi và lịch sử gia đình về bệnh tiểu đường. 

**Bộ dữ liệu Pima Diabetes bao gồm**
Số lượng thuộc tính: 9 

Số lượng mẫu: 768

**Diabetes bao gồm các thuộc tính**: Preg: số lần mang thai,  Plas: nồng độ glucose,  Pres: huyết áp,  Skin: : độ dày nếp gấp da, Insu: nồng độ Insulin, Mass: chỉ số BMI, Pedi: chức năng phả hệ đái tháo đường, Age: tuổi,  Class : chẩn đoán mắc bệnh có – có ăn kiêng hoặc không mắc bệnh – không ăn kiêng

Trong đề tài này em sẽ dựa vào các kết quả thu thập được từ bộ dữ liệu trong quá khứ cùng với phương pháp khai phá dữ liệu phân lớp bằng thuật toán Cây quyết định để tiến hành đưa ra quyết định chẩn đoán cũng như quyết định chế độ ăn kiêng cho bệnh nhân. Hình bên dưới là thông tin chỉ số của một vài bệnh nhân trong tập dữ liệu dự đoán mà em thu thập được.
![image](https://github.com/user-attachments/assets/6906dd65-8317-4f4c-aafc-ba70c4e092d5)

## 3. Ứng dụng khai phá dữ liệu với Weka
### 3.1 Chuẩn bị dữ liệu 
#### 3.1.1 Nạp dữ liệu 
1.	Nhúng dữ liệu vào database: chèn file **diabetes.csv** vào database **miningData**
   
Click chuột phải vào database **miningData -> Task -> Inport Flat File**

3.	Đổ dữ liệu từ SQL server lên SQL-viewer

Mở Weka -> chọn Explorer -> Open DB… -> thiết lập database URL

![image](https://github.com/user-attachments/assets/772e8403-8b17-474a-92fb-b31e0725c7b8)

	Ở đây Server name là: DESKTOP-V1R5VJP\HOA Tài khoản: sa ,  Mật khẩu: 123 => Kết nối thành công sẽ được hiển thị lên phần thông báo
 
**Load dữ liệu lên SQL-viewer**

 ![image](https://github.com/user-attachments/assets/9191323f-0a61-4608-9a4f-71e18b7f2f0e)

**Đổ dữ liệu lên Weka**

 ![image](https://github.com/user-attachments/assets/e3c14646-74fb-4410-ab0d-c67942512932)

 **Xem thông tin dữ liệu trên Weka**
![image](https://github.com/user-attachments/assets/1657e9e8-d1c5-415a-bb7c-b64c94a2298d)

#### 3.1.2 Lọc thuộc tính

**- Phương pháp mean/mode**: Phương pháp này sẽ thay thế các giá trị thiếu bằng giá trị trung bình (mean) đối với các thuộc tính số hoặc giá trị mode đối với các thuộc tính rời rạc. Ở đây chúng em dùng cách này

**- Phương pháp k-NN**: Phương pháp này sẽ tìm kiếm k mẫu dữ liệu giống nhất 
(có khoảng cách Euclidean gần nhất) với mẫu dữ liệu cần thay thế và dùng các giá trị của k mẫu dữ liệu này để tính toán giá trị mới thay thế.

**Thông tin dữ liệu bị thiếu**
![image](https://github.com/user-attachments/assets/b28fecd6-d56e-4780-8218-5b8a2d25be4e)

**Sử dụng bộ lọc ReplaceMissingValues**

![image](https://github.com/user-attachments/assets/f45cb421-325c-4554-9295-44cd517dac82)

**Chèn dữ liệu bị thiếu thành công**

![image](https://github.com/user-attachments/assets/c81c64ef-5fc5-42f6-b51b-a9d462165565)

### 3.2 Lập mô hình

**Phân lớp cho bộ dữ liệu dựa vào Cây quyết định J48**

![image](https://github.com/user-attachments/assets/3d1ca48e-37c2-4630-9aa4-29488ef12ba7)

-	Tiếp đến ta chọn Cross-validation để chọn số Fold nên để mặc định là 10. Sau đó vào More option để thiết lập Outpt. Tại đây ta có thể tích thêm vào mục Output prediction để hiện thêm phần dự báo.
  
Hoặc có thể lựa chọn các tùy chọn cho việc kiểm tra (test options)

•	Use training set. Bộ phận lọc sẽ được đánh giá trên tập học

•	Supplied test set. Sử dụng một tập dữ liệu khác(với tập học) để cho việc đánh giá

•	Cross-validation. Tập dữ liệu sẽ được chia đều thành k tập (folds) có kích thước xấp xỉ nhau, các bộ phận loại học sẽ được đánh giá bởi phương pháp Cross-validation

•	Percentage split. Chỉ định tỷ lệ phân chia tập dữ liệu đối với việc đánh giá

Kết quả phân lớp bằng cây quyết định
![image](https://github.com/user-attachments/assets/fc6b6f82-4ca5-4544-b770-dee2f87def00)    ![image](https://github.com/user-attachments/assets/9c400743-62be-4c06-a0f8-45ca2574dbeb)

**Mô hình cây quyết định:**

![image](https://github.com/user-attachments/assets/518da6bc-a25f-4b44-acf8-8917b929f43b)

### 3.3 Đánh giá mô hình

![image](https://github.com/user-attachments/assets/db8da922-4631-4a22-b5c4-fe3ecda04cdd)

**Summary**
Số mẫu phân lớp đúng: 567-  tỉ lệ 73,8281%. Số mẫu phân lớp sai: 201 - tỉ lệ 26,1719%

**Chỉ số Kappa Statistic** : 0,4164 cho thấy mức độ đồng ý giữa dự đoán của J48 và các nhãn thực tế tương đối thấp

**Root Mean Squared Error (RMSE)**:  0,4463 - đây là giá trị trung bình của độ lệch giữa giá trị dự đoán của mô hình và giá trị thực tế của các điểm dữ liệu trong tập kiểm tra. 

**Mean Absolute Error (MAE):** 0,3158  -  đây là giá trị trung bình của độ lệch tuyệt đối giữa giá trị dự đoán của mô hình và giá trị thực tế của các điểm dữ liệu trong tập kiểm tra. 

**Relative Absolute Error (RAE):** đây là tỷ lệ giữa Mean Absolute Error và trung bình giá trị tuyệt đối của các giá trị thực tế trong tập kiểm tra.

**Detailed Accuracy By Class**
**TP Rate**: được tính bằng tỷ lệ số mẫu thuộc lớp đó được phân loại đúng trên tổng số mẫu dữ liệu thuộc lớp đó. Ví dụ: lớp “TieuDuong_CanAnKieng” là 0.814, có nghĩa là 81.4% số mẫu thuộc lớp TieuDuong_CanAnKieng đã được dự đoán chính xác 

**FP Rate**: Tỉ lệ các mẫu  không thuộc lớp đó nhưng lại bị dự đoán thuộc lớp đó trên tổng số các trường hợp thực tế không thuộc lớp đó. Ví dụ, nếu FP Rate của lớp TieuDuong_CanAnKieng là 0.403 , có nghĩa là 40.3% số mẫu không thuộc lớp TieuDuong_CanAnKieng lại bị dự đoán là thuộc lớp TieuDuong_CanAnKieng

**Độ chính xác - Precision:** Tỉ lệ các trường hợp thuộc lớp đó được dự đoán đúng trên tổng số các trường hợp được dự đoán thuộc lớp đó. Ví dụ, nếu Precision của lớp TieuDuong_CanAnKieng là 0.79, có nghĩa là trong tổng số các mẫu được dự đoán thuộc lớp TieuDuong_CanAnKieng, chỉ có 79% là thực sự thuộc lớp đó.

**Recall:** Tỉ lệ các trường hợp thuộc lớp đó được dự đoán đúng trên tổng số các trường hợp thực tế thuộc lớp đó. Ví dụ, nếu Recall của lớp TieuDuong_ CanAnKieng  là 0.814, có nghĩa là trong tổng số các mẫu thuộc lớp TieuDuong_ CanAnKieng, có 81.4 % được dự đoán đúng.

**F-Measure**: Trung bình điều hòa giữa Precision và Recall, được tính bằng công thức F1 = 2 * (Precision * Recall) / (Precision + Recall). F-Measure thường được dùng để đánh giá hiệu suất của mô hình phân loại. 
Vd: F-Measure (lớp TieuDuong_CanAnKieng)= 2*(0,79+0,814)/(0,79+0.814) =0.802

**MCC** : là một thước đo được sử dụng để đánh giá chất lượng của một mô hình phân loại. MCC là một số từ -1 đến 1, trong đó giá trị 1 đại diện cho một mô hình hoàn hảo, 0 cho một mô hình ngẫu nhiên, và -1 cho một mô hình hoàn toàn sai. MCC cho cả hai lớp bị tiểu đường và không tiểu đường đều là 0.417. Điều này có nghĩa là mô hình phân loại đúng một phần khá tốt, nhưng vẫn còn đánh giá thấp so với một mô hình hoàn hảo.

**ROC Area:** Đây là diện tích dưới đường cong ROC (Receiver Operating Characteristic) của mô hình. ROC Curve là một đường cong biểu thị tỷ lệ giữa true positive rate (TPR) và false positive rate (FPR) cho một loạt các ngưỡng quyết định khác nhau của mô hình. ROC Area cho cả hai bị tiểu đường và không tiểu đường đều là 0.751, chỉ ra rằng mô hình có khả năng phân loại tốt cả hai lớp.

**PRC Area hay Average Precision** là diện tích dưới đường cong Precision-Recall Curve, một thước đo đánh giá hiệu quả của mô hình phân loại trên toàn bộ phạm vi threshold. PRC Area/Average Precision càng cao thì mô hình càng tốt trong việc phân loại dữ liệu

Tương tự như vậy cho lớp KhoeManh_KhongKieng, nói tóm lại 2 dòng đầu tiên là thống kê độ do cho từng lớp và dòng cuối cùng là trung bình cộng của cả mẫu

**Confusion Matrix ma trận nhầm lẫn biểu diễn rằng:**

+ Lớp TieuDuong_CanAnKieng có 407 mẫu phân lớp đúng và 93 mẫu phân lớp sai ( có thể hiểu là ban đầu có 93 mẫu lớp Âm tính bị phân loại nhầm vào lớp Dương tính)

+ Lớp KhoeManh_KhongKieng có 160 mẫu phân lớp đúng và 108 mẫu phân lớp sai

#### 3.4 Triển khai mô hình

  Phân lớp Cây quyết định cho bộ dữ liệu dự đoán TieuDuong_predict
  
![image](https://github.com/user-attachments/assets/317721a7-c4fb-4c3b-ab14-ceba6c597c10)

Kết quả chạy mô hình dự đoán 

![image](https://github.com/user-attachments/assets/01041db7-5f13-4d8b-b79e-1e50b2edf2d3)

Kết quả trả về gồm số thứ tự dòng, giá trị dự đoán, phép sai số của từng kết quả dự đoán. Sau khi thực hiện phương pháp phân lớp với cây quyết định bằng thuật toán J48, kết quả đạt được là ta có thể dự đoán kết quả chẩn đoán bệnh tiểu đường dựa vào cây quyết định và mức đo tính toán độ chính xác khi đưa ra các kết quả dự đoán

## 4. Ứng dụng khai phá dữ liệu với R

### 4.1 Chuẩn bị dữ liệu

1.	Load dữ liệu chẩn đoán bệnh tiểu đường từ file diabetes.csv bằng lệnh:

  ![image](https://github.com/user-attachments/assets/6531d9e4-782c-4893-b099-d12c4f36e903)

  -	Có thể xem thông tin dữ liệu bằng các câu lệnh

**head(mydata)**     # xem 6 dòng đầu tiên của dữ liệu

![image](https://github.com/user-attachments/assets/cd8bfffd-bda1-4b45-b464-228f7c618556)

**summary(mydata)**   # tóm tắt các thông số thống kê của dữ liệu

![image](https://github.com/user-attachments/assets/11735540-1144-4c84-b44b-afd66daccea5)

Bằng câu lệnh summary(mydata), ta thấy được ở thuộc tính pres có 2 giá trị bị thiếu, ở thuộc tính mass có 1 giá trị bị thiếu. 

Các biến Min, Max, Median, Mean  là giá trị nhỏ nhất, lớn nhất, trung vị, trung bình. 1st Qu, 3rd Qu là  Giá trị của phần tư thứ nhất (phân vị thứ 25), Giá trị của phần tư thứ 3 (phân vị thứ 75)

**str(mydata)**       # kiểm tra kiểu dữ liệu 

![image](https://github.com/user-attachments/assets/3956d3c9-e793-4d0c-afb9-1cf3a34e14d5)

2.	Chuyển đổi các biến đầu vào thành kiểu số và kiểu factor nếu cần

   ![image](https://github.com/user-attachments/assets/102dab40-a69b-433b-900e-008097d59969)

3.	Lọc các giá trị kiếm khuyết ở cột pres và mass:

Ta có thể loại bỏ bằng câu lệnh sau sau:

![image](https://github.com/user-attachments/assets/bd87991d-a859-40b0-87dd-fb7b415c17c1)

![image](https://github.com/user-attachments/assets/cb5a4137-056f-4af4-beee-c4e099f29025)

4.	Chia tập dữ liệu thành tập huấn luyện và tập kiểm tra. Điều này giúp đảm bảo rằng cây quyết định được xây dựng trên tập huấn luyện và được đánh giá trên tập kiểm tra để đánh giá độ chính xác

   ![image](https://github.com/user-attachments/assets/2eaad6c4-6fba-41c1-a136-d6b95e3b6880)

### 4.2 Xây dựng cây quyết định

Sử dụng hàm "rpart" để xây dựng cây quyết định, với đối số đầu vào là dữ liệu huấn luyện và biến phụ thuộc cần dự đoán ("KetLuan"):

![image](https://github.com/user-attachments/assets/5b34c73f-876b-4bba-b8d4-a7fa96a4cfb0)

•**"KetLuan"** là biến phụ thuộc, " ~ ." có nghĩa là sử dụng tất cả các biến đầu vào để dự đoán KetLuan

•**method = "class"** là phương pháp được sử dụng để xây dựng cây quyết định

**Vẽ cây quyết định:**

Sử dụng packege rpart.plot để vẽ cây

![image](https://github.com/user-attachments/assets/a38fc950-2f30-423f-948e-640357a414c4)

![image](https://github.com/user-attachments/assets/7afd689e-2674-4bd8-9581-039bd57549b5)

### 4.3 Đánh giá mô hình

Ma trận nhầm lẫn của dự liệu TieuDuong trên R

![image](https://github.com/user-attachments/assets/0beacec4-597d-4bd9-a1ec-3cb682599040)

===> Ma trận nhầm lẫn cho ta thấy:

Lớp KetLuan có giá trị “TieuDuong_CanAnKieng”: có 126 mẫu dữ liệu dữ đoán chính xác và 42 mẫu dữ liệu dự đoán sai (bị nhầm sang “KhoeManh_ KhongKieng”)

Lớp KetLuan có giá trị “KhoeManh_KhongKieng”: có 38 mẫu dự đoán đúng và 26 mẫu dự đoán sai 

Chỉ số Accuracy: 0,704347… => Tỉ lệ chính xác trung bình không cao lắm

### 4.4 Triển khai mô hình

1.	Load dữ liệu dự đoán vào

   ![image](https://github.com/user-attachments/assets/4cb3f7fc-1898-4215-8d9a-3fa60e8d7f9e)

Sau đó, có thể sử dụng mô hình đã xây dựng để dự đoán KetLuan trên dữ liệu mới bằng cách sử dụng lệnh sau:

![image](https://github.com/user-attachments/assets/d025ea8a-21db-41cf-bacd-c4e256c26892)

==> In ra mô hình dự đoán kết quả

![image](https://github.com/user-attachments/assets/de78978a-3f9b-4be5-aa6b-1d20e715efd7)

Sau khi thực hiện phương pháp phân lớp với cây quyết định bằng trên phần mềm R, kết quả đạt được là ta có thể dự đoán kết quả chẩn đoán bệnh tiểu đường dựa vào cây quyết định và tỉ lệ chính xác của mô hình 

Tuy nhiên ta có thể thấy rằng mô hình cây quyết định J48 trên Weka cho kết quả độ chính xác cao hơn so với mô hình cây quyết định trên R, có thể được giải thích bởi việc sử dụng các tham số khác nhau cho mỗi mô hình, cũng như sự ngẫu nhiên trong quá trình chia dữ liệu huấn luyện và kiểm tra. Nhưng ta có thể thay đổi các tiêu chí phân lớp để thực hiện phương pháp phân lớp với cây quyết bằng nhiều thuật toán khác nhau để có dự đoán ra các kết quả phù hợp trong thực tế








