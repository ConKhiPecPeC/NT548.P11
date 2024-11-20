# NT548.P11

## Triển khai hạ tầng AWS với CloudFormation và tự động hóa quy trình build và deploy
### với AWS CodePipeline

### Các thành phần cần chuẩn bị
- `AWS_ACCESS_KEY`: Khóa truy cập AWS.
- `AWS_SECRET_ACCESS_KEY`: Khóa bí mật AWS.

### Các bước triển khai
1. Tạo repo trên CodeCommit
    - Tạo 1 repository mới
    - Tiến hành push các file đã tạo lên repository: .taskcat.yml, buildspec.yml, group_19.yaml
2. Tạo project trên CodeBuild:
    - Chọn mã nguồn cho build:

    + Source provider: Chọn AWS CodeCommit.

    + Repository: Chọn repository đã tạo trên CodeCommit.

    + Branch: Chọn main hoặc branch phù hợp 

    - Environment image: Chọn Managed image (AWS CodeBuild sẽ tự động cung cấp môi trường build).

    + Operating system: Chọn Ubuntu.

    + Runtime: Chọn Standard (cho phép sử dụng tệp buildspec.yml).

    + Build image: Chọn một image tương thích, ví dụ aws/codebuild/python-3.8
    
    + Buildspec: Chọn file Buildspec đã được push lên CodeCommit

    - Chọn Create build project để lưu cấu hình.

    - Chọn Start build để bắt đầu quá trình build.

3. Tạo pipeline trong CodePipeline
    Bao gồm 3 giai đoạn: 

    - Source: Lấy mã nguồn từ CodeCommit.

    - Build: Xây dựng mã nguồn và kiểm tra CloudFormation template bằng CodeBuild.

    - Deploy: Triển khai template CloudFormation bằng AWS CloudFormation.

    B1: Tạo project trong CodePipeline với tùy chọn Custom Pipeline

    B2: Đặt tên cho pipeline cũng như gắn các role cần thiết

    B3: Cấu hình Source stage là repository trong CodeCommit

    B4: Cấu hình Build stage là project đã tạo trong CodeBuild

    B5: Cấu hình Deploy stage là AWS cloudformation

    B6: Sau khi đã lưu cấu hình, tiến hành commit và push code lên CodeCommit để theo dõi pipeline.






