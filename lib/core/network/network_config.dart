import 'dart:io';

class NetworkConfig {
  static final chatWebSocket =
      Platform.isAndroid ? 'ws://10.0.2.2:4000' : 'ws://localhost:4000';

  static const String weatherApiUrl =
      'http://api.openweathermap.org/data/2.5/weather';
}
