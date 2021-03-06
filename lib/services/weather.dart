import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:clima/utilities/constants.dart';

class WeatherModel {
  final String openWeatherMap =
      'https://api.openweathermap.org/data/2.5/weather?';

  Future<dynamic> getLocation() async {
    Location location = Location();
    await location.getCurrentLocation().timeout(
      Duration(seconds: 5),
      onTimeout: () {
        return null;
      },
    );

    NetworkHelper networkHelper = NetworkHelper(
        url: openWeatherMap +
            'lat=${location.latitude}&lon=${location.longitude}&appid=$kApiKeyWeather&units=metric');
    var weatherData = await networkHelper.getData();

    return weatherData;
  }

  Future<dynamic> getCityWeather(String city) async {
    NetworkHelper networkHelper = NetworkHelper(
        url: openWeatherMap + 'q=$city&appid=$kApiKeyWeather&units=metric');
    var weatherData = await networkHelper.getData();

    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
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
