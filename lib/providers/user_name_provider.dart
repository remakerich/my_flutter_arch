import 'package:flutter_riverpod/flutter_riverpod.dart';

final userNameProvider = StateProvider.autoDispose<String>(
  (ref) => '',
);
