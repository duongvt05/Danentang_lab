import 'package:lab9/utilities/constants.dart';
// import 'package:lab9/services/location.dart'; // Không cần dùng nữa
// import 'package:lab9/services/networking.dart'; // Không cần dùng nữa

class WeatherModel {
  
  // Hàm lấy thời tiết vị trí hiện tại (Giả lập)
  Future<dynamic> getLocationWeather() async {
    // Giả lập độ trễ mạng 1 giây để trải nghiệm giống thật hơn (tùy chọn)
    await Future.delayed(const Duration(seconds: 1));

    // Trả về dữ liệu cứng (Mock Data)
    return {
      "coord": {"lon": 108.2208, "lat": 16.0471},
      "weather": [
        {
          "id": 800, // Mã 800 là trời quang (Clear) -> Icon ☀
          "main": "Clear",
          "description": "clear sky",
          "icon": "01d"
        }
      ],
      "base": "stations",
      "main": {
        "temp": 28.5, // Nhiệt độ giả định là 28.5 độ C
        "feels_like": 30.0,
        "temp_min": 28.0,
        "temp_max": 28.0,
        "pressure": 1012,
        "humidity": 70
      },
      "visibility": 10000,
      "wind": {"speed": 4.12, "deg": 120},
      "clouds": {"all": 20},
      "dt": 1625482576,
      "sys": {
        "type": 1,
        "id": 9306,
        "country": "VN",
        "sunrise": 1625436912,
        "sunset": 1625484321
      },
      "timezone": 25200,
      "id": 1583992,
      "name": "Da Nang", // Tên thành phố giả định
      "cod": 200
    };
  }

  // Hàm lấy thời tiết theo tên thành phố (Giả lập)
  Future<dynamic> getCityWeather(String city) async {
    await Future.delayed(const Duration(seconds: 1));

    // Trả về dữ liệu cứng nhưng đổi nhiệt độ khác để test UI
    return {
      "weather": [
        {
          "id": 600, // Mã 600 là Tuyết -> Icon ☃
          "main": "Snow",
          "description": "light snow",
          "icon": "13d"
        }
      ],
      "main": {
        "temp": 5.0, // Giả định 5 độ C
        "pressure": 1012,
        "humidity": 80,
      },
      "name": city, // Trả về đúng tên thành phố user nhập
      "cod": 200
    };
  }

  // --- Các hàm UI giữ nguyên ---

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔';
    } else if (condition < 700) {
      return '☃';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀';
    } else if (condition <= 804) {
      return '☁';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}