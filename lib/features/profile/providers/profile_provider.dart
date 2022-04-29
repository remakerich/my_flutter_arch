import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myarchapp/core/injection/injection.dart';
import 'package:myarchapp/features/profile/services/profile_service.dart';

final profileProvider =
    StateNotifierProvider.autoDispose<LoginNotifier, AsyncValue<String>>(
  (ref) {
    return LoginNotifier(
      getIt<ProfileService>(),
    );
  },
);

class LoginNotifier extends StateNotifier<AsyncValue<String>> {
  LoginNotifier(
    this._profileService,
  ) : super(const AsyncLoading()) {
    started();
  }

  final ProfileService _profileService;

  void started() {
    state = const AsyncLoading();

    final result = _profileService.getUserName();

    result.when(
      left: (failure) => state = AsyncError(failure),
      right: (name) => state = AsyncData(name),
    );
  }
}
