import 'package:flutter/material.dart';
// Dùng đường dẫn tương đối để tránh lỗi package name
import 'city_screen.dart'; 
import '../services/weather.dart';
import '../utilities/constants.dart';


class LocationScreen extends StatefulWidget {
  // Thêm const và key cho đúng chuẩn Flutter mới
  const LocationScreen({super.key, this.locationWeather});

  final dynamic locationWeather;

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel model = WeatherModel();

  // 1. SỬA LỖI NULL SAFETY: Gán giá trị mặc định ban đầu
  int temp = 0;
  String weatherIcon = 'Error';
  String message = 'Unable to get weather data';
  String description = '';
  String city = '';
  String countryCode = '';
  Duration timeBeforeSunrise = Duration.zero;
  Duration timeBeforeSunset = Duration.zero;

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic data) {
    setState(() {
      if (data == null) {
        temp = 0;
        weatherIcon = 'Error';
        message = 'Unable to get weather data';
        description = '';
        city = '';
        countryCode = '';
        timeBeforeSunrise = Duration.zero;
        timeBeforeSunset = Duration.zero;
        return;
      }

      // Ép kiểu an toàn
      double tempDouble = data['main']['temp'].toDouble(); 
      temp = tempDouble.toInt();
      
      var condition = data['weather'][0]['id'];
      weatherIcon = model.getWeatherIcon(condition);
      message = model.getMessage(temp);
      description = data['weather'][0]['description'];
      city = data['name'];
      countryCode = data['sys']['country'];

      DateTime now = DateTime.now().toUtc();
      DateTime sunrise = DateTime.fromMillisecondsSinceEpoch(
        data['sys']['sunrise'] * 1000,
        isUtc: true,
      );
      DateTime sunset = DateTime.fromMillisecondsSinceEpoch(
        data['sys']['sunset'] * 1000,
        isUtc: true,
      );
      timeBeforeSunrise = now.difference(sunrise);
      timeBeforeSunset = now.difference(sunset);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.8),
              BlendMode.dstATop,
            ),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  // 2. SỬA LỖI FLATBUTTON -> TEXTBUTTON
                  TextButton(
                    onPressed: () async {
                      var weatherData = await model.getLocationWeather();
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                      color: Colors.white,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var typedCity = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CityScreen(),
                        ),
                      );
                      if (typedCity != null) {
                        var weatherData = await model.getCityWeather(typedCity);
                        updateUI(weatherData);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(weatherIcon, style: kConditionTextStyle),
                  Row(
                    children: [
                      Text(temp.toString(), style: kTempValueTextStyle),
                      SizedBox(width: 10.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: kTempUnitBoxDecoration, // Đảm bảo biến này có trong constants.dart
                            child: Text("O", style: kTempUnitTextStyle),
                          ),
                          Text("now", style: kTempSubTextStyle),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    // 3. Xóa string interpolation thừa ($message -> message)
                    Text(
                      message,
                      textAlign: TextAlign.right,
                      style: kMessageTextStyle,
                    ),
                    SizedBox(height: 10.0),
                    Text.rich(
                      TextSpan(
                        text: "There's $description in ",
                        style: kDescriptionTextStyle, // Đảm bảo biến này có trong constants.dart
                        children: [
                          TextSpan(
                              text: "$city, $countryCode",
                              style: TextStyle(fontStyle: FontStyle.italic))
                        ],
                      ),
                      textAlign: TextAlign.right,
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    border: Border.all(color: Colors.blueGrey, width: 3.0),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 40.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              "images/sunrise.png",
                              width: 64.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "${timeBeforeSunrise.inHours.abs()}h ${timeBeforeSunrise.inMinutes % 60}min",
                                  style: kSunTitleTextStyle, // Đảm bảo biến này có trong constants.dart
                                ),
                                Text(
                                  "${timeBeforeSunrise.isNegative ? "before" : "after"} sunrise",
                                  style: kSunBodyTextStyle,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              "images/sunset.png",
                              width: 64.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "${timeBeforeSunset.inHours.abs()}h ${timeBeforeSunset.inMinutes % 60}min",
                                  style: kSunTitleTextStyle,
                                ),
                                Text(
                                  "${timeBeforeSunset.isNegative ? "before" : "after"} sunset",
                                  style: kSunBodyTextStyle,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}