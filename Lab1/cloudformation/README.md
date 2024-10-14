# NT548.P11

## Hướng Dẫn Thiết Lập Hạ Tầng AWS Bằng CloudFormation

### Mô tả

Sử dụng Terraform để triển khai hạ tầng AWS với các thành phần chính như sau:

_VPC_: Tạo VPC với Public Subnet (kết nối Internet) và Private Subnet (sử dụng NAT Gateway). Bao gồm Internet Gateway và Default Security Group.

_Route Tables_: Cấu hình Public Route Table cho lưu lượng Internet qua Internet Gateway và Private Route Table cho lưu lượng qua NAT Gateway.

_NAT Gateway_: Cho phép kết nối Internet cho tài nguyên trong Private Subnet với tính bảo mật.

_EC2 Instances_: Tạo Public EC2 Instance có thể truy cập từ Internet và Private EC2 Instance chỉ có thể truy cập từ Public EC2 Instance. Các Instance này sử dụng một cặp khóa RSA để có thể truy cập vào.

_Security Groups_: Kiểm soát lưu lượng vào/ra cho các EC2 Instances với Public Security Group cho phép kết nối SSH từ IP cụ thể và Private Security Group cho phép kết nối từ Public EC2 Instance.

### Yêu cầu

Trước khi bắt đầu triển khai hạ tầng trên AWS bằng Terraform, cần chuẩn bị các tài nguyên:

_AWS account: để có thể tạo các tài nguyên

_AWS CLI_: Cài đặt AWS Command Line Interface (CLI) từ trang chủ AWS CLI để tương tác với AWS từ dòng lệnh.

_IAM (Identity and Access Management)_: Là dịch vụ của AWS cho phép quản lý quyền truy cập vào các dịch vụ và tài nguyên của AWS.

_File yaml đã cấu hình với tất cả các tài nguyên cần thiết.

### Các bước triển khai

- Login vào AWS account với tên user, password

- Sử dụng CloudFormation để tạo các tài nguyên:

    CloudFormation -> Tạo stack mới -> Upload file yaml đã chuần bị trực tiếp lên AWS -> Đợi cho đến khi tất cả tài nguyên được tạo

    




