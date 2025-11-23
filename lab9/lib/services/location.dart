import 'package:geolocator/geolocator.dart';

class Location {
  // SỬA LỖI: Thêm dấu ? để chấp nhận giá trị null (khi chưa lấy được tọa độ)
  double? latitude;
  double? longitude;

  Future<void> getCurrentLocation() async {
    try {
      // BƯỚC QUAN TRỌNG: Kiểm tra quyền truy cập vị trí trước
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // Nếu người dùng từ chối thì dừng lại
          return;
        }
      }

      // Lấy vị trí hiện tại
      Position position = await Geolocator.getCurrentPosition(
        // Sửa lỗi cú pháp LocationSettings cho bản mới (nếu cần), 
        // nhưng desiredAccuracy vẫn dùng được ở hầu hết phiên bản.
        desiredAccuracy: LocationAccuracy.high,
      );

      latitude = position.latitude;
      longitude = position.longitude;
      
    } catch (e) {
      print(e);
    }
  }
}