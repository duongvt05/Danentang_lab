import 'package:flutter/material.dart';

// ⚠️ QUAN TRỌNG: Bạn hãy thay dòng bên dưới bằng API Key thật của bạn từ openweathermap.org
// Nếu chưa có, hãy đăng ký tài khoản miễn phí để lấy key.
const kOwmApiKey = 'de731302a822be764fb06e77c3f13baa'; 

// Đường dẫn gốc của OpenWeatherMap
const kOwmUrl = 'https://api.openweathermap.org/data/2.5/weather';

// --- CÁC STYLE CHO GIAO DIỆN ---

const kTempTextStyle = TextStyle(
  fontFamily: 'Spartan',
  fontSize: 100.0,
);

const kMessageTextStyle = TextStyle(
  fontFamily: 'Spartan',
  fontWeight: FontWeight.bold,
  fontSize: 50.0,
);

const kButtonTextStyle = TextStyle(
  fontSize: 30.0,
  fontFamily: 'Spartan',
  fontWeight: FontWeight.bold,
  color: Colors.white,
);

const kConditionTextStyle = TextStyle(
  fontSize: 100.0,
);

// Style cho ô nhập liệu (Input)
const kTextFieldInputDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  icon: Icon(
    Icons.location_city,
    color: Colors.white,
  ),
  hintText: 'Enter City Name',
  hintStyle: TextStyle(
    color: Colors.grey,
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10.0),
    ),
    borderSide: BorderSide.none,
  ),
);

// Style cho số nhiệt độ to đùng
const kTempValueTextStyle = TextStyle(
  fontFamily: 'Spartan',
  fontWeight: FontWeight.w900,
  fontSize: 80.0,
  color: Colors.white,
);

// Style cho chữ "O" (độ)
const kTempUnitTextStyle = TextStyle(
  fontFamily: 'Spartan',
  fontWeight: FontWeight.w900,
  fontSize: 40.0,
  height: 1.0, // Giúp căn chỉnh tốt hơn
  color: Colors.white,
);

// Style cho chữ "now" bên dưới
const kTempSubTextStyle = TextStyle(
  fontFamily: 'Spartan',
  fontSize: 24.0,
  letterSpacing: 5.0,
  color: Colors.grey,
);

// Style cho mô tả thời tiết (ví dụ: "light rain")
const kDescriptionTextStyle = TextStyle(
  fontFamily: 'Spartan',
  fontSize: 30.0,
  color: Colors.white,
);

// Style cho tiêu đề giờ mọc/lặn
const kSunTitleTextStyle = TextStyle(
  fontSize: 18.0,
  fontFamily: 'Spartan',
  fontWeight: FontWeight.bold,
  color: Colors.white,
  letterSpacing: 1.0,
);

// Style cho chữ "sunrise/sunset"
const kSunBodyTextStyle = TextStyle(
  fontFamily: 'Spartan',
  fontSize: 14.0,
  color: Colors.grey,
);

// Trang trí cho chữ O (Vòng tròn hoặc gạch chân)
const kTempUnitBoxDecoration = BoxDecoration(
  // Nếu bạn thích gạch chân:
  // border: Border(bottom: BorderSide(width: 5.0, color: Colors.white)),
  
  // Nếu bạn thích vòng tròn mờ (đẹp hơn cho giao diện hiện tại):
  shape: BoxShape.circle,
  color: Colors.transparent,
);