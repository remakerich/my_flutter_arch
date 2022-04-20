import 'dart:io';

class NetworkConfig {
  static final serverUrl =
      Platform.isAndroid ? 'ws://10.0.2.2:4000' : 'ws://localhost:4000';
}
