
# Task 3

Sử dụng Jenkins để quản lý quy trình CI/CD cho ứng dụng microservices

## Yêu cầu

- Sử dụng Jenkins để tự động hóa quá trình build, test và deploy ứng dụng microservices lên Docker, Kubernetes (hoặc một dịch vụ tương ứng).
- Tích hợp SonarQube để kiểm tra chất lượng mã nguồn
- Có thể tích hợp thêm các công cụ kiểm tra bảo mật như Snyk hoặc Trivy để tăng cường tính an toàn của mã nguồn (tùy chọn).

## Công cụ
**Code:**[SourceCode] (https://github.com/tuan-devops/kubernetes-sample-apps.git)
**Jenkins**
**SonarQube**
**Docker**
**DockerHub**[Link](https://hub.docker.com/repository/docker/conkhipecpec/2048-jenkins)

## Run local
Clone the project

```bash
  git clone https://github.com/tuan-devops/kubernetes-sample-apps.git
```

Go to the project directory

```bash
  cd game-2048-example
```

Build Docker Image

```bash
  docker build -t <IMAGE_NAME> .
```

Run docker container

```bash
  docker run -d -p 80:8080 --name <CONTAINER_NAME> <IMAGE_NAME>
```

## Jenkins
Các plugin cài đặt 
- Docker Plugin
- Docker Pineline 
- GitHub Integration Plugin 
- Publish over SSH  
- Sonar Quality Gates Plugin 
- SonarQube Scanner for Jenkins
- Và các plugins được gợi ý khi tiến hành cài đặt jenkins....

## Các stage trong CI/CD pineline
1. Check out SCM
2. Scan code với SonarQube
3. Check code đã scan với Quality gate
4. Build docker image
5. Push docker image lên Docker Hub
6. SSH tới Server Deployment 
7. Pull image từ DockerHub về và run images 
Nếu là bản cập nhật images mới thì dừng và xóa conatiner hiện tại pull image mới và chạy lại container khác