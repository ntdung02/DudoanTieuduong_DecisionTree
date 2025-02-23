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

## 3. Chuẩn bị dữ liệu 

### 3.1 Nạp dữ liệu 
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

### 3.3 Lọc thuộc tính

**- Phương pháp mean/mode**: Phương pháp này sẽ thay thế các giá trị thiếu bằng giá trị trung bình (mean) đối với các thuộc tính số hoặc giá trị mode đối với các thuộc tính rời rạc. Ở đây chúng em dùng cách này

**- Phương pháp k-NN**: Phương pháp này sẽ tìm kiếm k mẫu dữ liệu giống nhất 
(có khoảng cách Euclidean gần nhất) với mẫu dữ liệu cần thay thế và dùng các giá trị của k mẫu dữ liệu này để tính toán giá trị mới thay thế.

**Thông tin dữ liệu bị thiếu**
![image](https://github.com/user-attachments/assets/b28fecd6-d56e-4780-8218-5b8a2d25be4e)

**Sử dụng bộ lọc ReplaceMissingValues**

![image](https://github.com/user-attachments/assets/f45cb421-325c-4554-9295-44cd517dac82)

**Chèn dữ liệu bị thiếu thành công**

![image](https://github.com/user-attachments/assets/c81c64ef-5fc5-42f6-b51b-a9d462165565)

## 3.3 Lập mô hình

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









