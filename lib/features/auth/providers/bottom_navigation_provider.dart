import 'package:flutter_riverpod/flutter_riverpod.dart';

final bottomNavigationProvider = StateProvider.autoDispose<int>(
  (ref) => 0,
);
