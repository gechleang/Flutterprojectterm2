// Observer
abstract class WeatherListener {
  void onTemperatureChanged(double temperature);
}

class WebApp extends WeatherListener {
  @override
  void onTemperatureChanged(double temperature) {
    print("web app : new temparature is $temperature");
  }
}

// Subject
class WeatherStation {
  double _temperature = 0.0;
  final List<WeatherListener> _listeners = [];

  void addListener(WeatherListener listener) {
    _listeners.add(listener);
  }

  void setTemperature(double newTemperature) {
    _temperature = newTemperature;
    _notifyListeners();
  }

  void _notifyListeners() {
    for (var listener in _listeners) {
      listener.onTemperatureChanged(_temperature);
    }
  }
}

// Observers
class PhoneDisplay implements WeatherListener {
  @override
  void onTemperatureChanged(double temperature) {
    print("📱 Phone Display: Temperature updated to $temperature°C");
  }
}

class Web implements WeatherListener{
  @override
  void onTemperatureChanged(double temperature) {
    print("web app : new temparature is $temperature");   
    // TODO: implement onTemperatureChanged
  }
}

// Tests
void main() {
  WeatherStation weatherStation = WeatherStation();

  PhoneDisplay phoneDisplay = PhoneDisplay();
  Web WeatherListener = Web();

  // Register observers
  weatherStation.addListener(phoneDisplay);
  weatherStation.addListener(WeatherListener);

  // Update temperature
  print("🌡 Setting temperature to 25°C...");
  weatherStation.setTemperature(25.0);

  print("🌡 Setting temperature to 30°C...");
  weatherStation.setTemperature(30.0);
}