import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myarchapp/core/injection/injection.dart';
import 'package:myarchapp/modules/profile/data/profile_service.dart';

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

  Future<void> started() async {
    state = const AsyncLoading();

    final result = await _profileService.getUserName();

    result.when(
      left: (failure) => state = AsyncError(failure),
      right: (name) => state = AsyncData(name),
    );
  }
}
