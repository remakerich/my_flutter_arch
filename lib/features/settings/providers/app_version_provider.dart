import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

final appVersionProvider =
    StateNotifierProvider<AppVersionNotifier, AsyncValue<String>>(
  (ref) {
    return AppVersionNotifier();
  },
);

class AppVersionNotifier extends StateNotifier<AsyncValue<String>> {
  AppVersionNotifier() : super(const AsyncData('')) {
    checkVersion();
  }

  Future<void> checkVersion() async {
    try {
      final _platform = await PackageInfo.fromPlatform();
      state = AsyncData(_platform.version);
    } catch (error) {
      state = const AsyncError('');
    }
  }
}
