import 'dart:convert';
import 'package:http/http.dart' as http;
// 1. Dùng đường dẫn tương đối cho an toàn
import '../utilities/constants.dart'; 

class NetworkHelper {
  final String url;

  NetworkHelper(this.url);

  Future<dynamic> getData() async {
    // 2. SỬA LỖI QUAN TRỌNG: http bản mới bắt buộc dùng Uri.parse()
    // Code cũ: http.get(url) -> Sẽ báo lỗi
    
    // Lưu ý: Đoạn nối chuỗi này giả định 'url' bạn truyền vào chưa có appid
    // Nếu url gốc đã có appid thì cẩn thận bị thừa.
    String fullUrl = "$url&units=metric&appid=$kOwmApiKey";
    
    try {
      http.Response res = await http.get(Uri.parse(fullUrl));

      if (res.statusCode == 200) {
        return jsonDecode(res.body);
      } else {
        print("${res.statusCode}: No weather data found");
      }
    } catch (e) {
      print(e);
    }
  }
}