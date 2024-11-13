[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/9O4F1fO8)
[![Open in Visual Studio Code](https://classroom.github.com/assets/open-in-vscode-2e0aaae1b6195c2367325f4f02e2d04e9abb55f0b24a779b69b11b9e10269abc.svg)](https://classroom.github.com/online_ide?assignment_repo_id=16950867&assignment_repo_type=AssignmentRepo)

# Bài kiểm tra giữa kỳ - Bài 1

- **Môn học:** Phát triển ứng dụng di động đa nền tảng 1
- **Giảng viên:** GVC.TS. Trần Trung Chuyên
- **Sinh viên:** Nguyễn Quang Đạo
- **Mã sinh viên:** 2121050451
- **Lớp:** DCCTCT66_05D
- **Đề tài:** Xây dựng và kiểm thử ứng dụng Quản lý sự kiện

# Demo bài làm: [Nhấn vào đây để xem video demo](./imagevideo_demo/demoAppEvent.mp4)

<img src="./imagevideo_demo/event_home_view.png" alt="code cấu trúc thư mục" width="170" height="300"><img src="./imagevideo_demo/event_detail_view.png" alt="code cấu trúc thư mục" width="170" height="300"><img src="./imagevideo_demo/notifi_error_event.png" alt="code cấu trúc thư mục" width="400" height="300"><img src="./imagevideo_demo/notifi_inside_event.png" alt="code cấu trúc thư mục" width="400" height="300"><img src="./imagevideo_demo/notifi_onside_event.png" alt="code cấu trúc thư mục" width="170" height="300"><img src="./imagevideo_demo/event_chart_view.png" alt="code cấu trúc thư mục" width="170" height="300">

## cấu trúc thư mục

<img src="./imagevideo_demo/cau truc thu muc.png" alt="code cấu trúc thư mục" width="300" height="200">

## event_notification_helper.dart

<img src="./imagevideo_demo/code tạo thông báo.png" alt="code thông báo" width="300" height="200">

## event_model.dart

<img src="./imagevideo_demo/code model 1.png" alt="code model" width="300" height="200"> <img src="./imagevideo_demo/code model 2.png" alt="code model" width="300" height="200">

## event_data_source.dart

<img src="./imagevideo_demo/code data source.png" alt="code data source" width="300" height="200">

## event_service.dart

<img src="./imagevideo_demo/code_event_service.png" alt="code_event_service" width="300" height="200">

## event_view.dart

<img src="./imagevideo_demo/code_event_view_1.png" alt="code_event_view_1" width="300" height="200"> <img src="./imagevideo_demo/code_event_view_2.png" alt="code_event_view_1" width="300" height="200"> <img src="./imagevideo_demo/code_event_view_3.png" alt="code_event_view_1" width="300" height="200">

## event_detail_view.dart

<img src="./imagevideo_demo/code detail view 1.png" alt="code_detail_event_view_1" width="300" height="200"> <img src="./imagevideo_demo/code detail view 2.png" alt="code_detail_event_view_1" width="300" height="200"> <img src="./imagevideo_demo/code detail view 3.png" alt="code_detail_event_view_1" width="300" height="200">

## event_chart_view.dart

<img src="./imagevideo_demo/code biểu đồ 1.png" alt="code biểu đồ" width="300" height="200"><img src="./imagevideo_demo/code biểu đồ 2.png" alt="code biểu đồ" width="300" height="200"><img src="./imagevideo_demo/code biểu đồ 3.png" alt="code biểu đồ" width="300" height="200">

# Hướng dẫn:

Chào mừng bạn đến với dự án Quản lý sự kiện! Tệp README này sẽ hướng dẫn bạn hoàn thành bài tập.

## Cấu trúc Dự án

Dưới đây là tổng quan về cấu trúc dự án:

```
/.github/workflows/
  flutter_test.yml
/test/
  event_model_test.dart
  event_service_test.dart
  event_view_test.dart
  main_test.dart
  event_detail_view_test.dart
/lib/
  main.dart
```

## Bắt đầu

### Yêu cầu

Đảm bảo rằng bạn đã cài đặt Flutter phiên bản 3.24.3 trở lên trên máy của mình. Bạn có thể làm theo hướng dẫn [tại đây](https://flutter.dev/docs/get-started/install) để cài đặt Flutter.

### Thiết lập Dự án

1. **Clone repository:**

Sau khi nhận bài tập từ Github Classroom, hãy sử dụng Visual Studio Code > View > Command Palette > Git: Clone để clone repository về máy của bạn. Hoặc sử dụng dòng lệnh sau:

```sh
git clone <repository-url>
```

Trong đó `<repository-url>` là URL của repository bạn vừa nhận được.

2. **Cài đặt các phụ thuộc:**

Sau khi clone repository, mở thư mục dự án trong Visual Studio Code và chạy lệnh sau để cài đặt các phụ thuộc:

```sh
flutter pub get
```

Phát triển ứng dụng của bạn bắt đầu bằng cách xem clip hướng dẫn sau:

<iframe width="560" height="315" src="https://www.youtube.com/embed/_qlCQVKW2jQ?si=tHhBuqRnOGaWR7xB" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>

### Chạy kiểm thử

Dự án bao gồm một số tệp kiểm thử nằm trong thư mục `test`. Các kiểm thử này sẽ tự động chạy bằng GitHub Actions như được định nghĩa trong tệp `.github/workflows/flutter_test.yml`.

Để chạy kiểm thử trên máy cục bộ, sử dụng lệnh sau:

```sh
flutter test
```

### Các tệp kiểm thử

- **main_test.dart:** Kiểm thử khởi động ứng dụng chính.
- **event_model_test.dart:** Kiểm thử lớp `EventModel`.
- **event_service_test.dart:** Kiểm thử lớp `EventService`.
- **event_view_test.dart:** Kiểm thử widget `EventView`.
- **event_detail_view_test.dart:** Kiểm thử widget
  `EventDetailView`.

### Hoàn thành bài tập

1. **Xem lại các kiểm thử đã cung cấp:** Hiểu rõ mỗi kiểm thử đang kiểm tra điều gì.
2. **Triển khai chức năng cần thiết:** Viết mã cần thiết trong thư mục `lib` để đảm bảo tất cả các kiểm thử đều thành công.
3. **Chạy kiểm thử:** Đảm bảo tất cả các kiểm thử đều thành công bằng cách chạy `flutter test`.

### Nộp Bài tập

Khi bạn đã hoàn thành bài tập và tất cả các kiểm thử đều thành công, hãy commit và push mã nguồn của mình lên Github. Bạn có thể kiểm tra kết quả kiểm thử trên tab Actions của repository. Nếu Status là Success, nghĩa la bạn đã hoàn thành bài tập.

Chúc bạn may mắn với bài tập!

---

revised
