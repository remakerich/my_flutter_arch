import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myarchapp/core/injection/injection.dart';
import 'package:myarchapp/core/router/router.dart';
import 'package:myarchapp/core/utils/ui.dart';
import 'package:myarchapp/core/l10n/localization.dart';
import 'modules/auth/controllers/login_provider.dart';
import 'modules/settings/controllers/language_provider.dart';
import 'modules/settings/controllers/theme_provider.dart';

void main() async {
  await initializeDependencies();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  MyApp({Key? key}) : super(key: key);
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(loginProvider);
    final languageState = ref.watch(languageProvider);
    final themeState = ref.watch(themeProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeState,
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(languageState),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
    );
  }
}
