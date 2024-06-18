import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pharma_et/l10n/l10n.dart';
import 'package:pharma_et/providers/LocaleProvider.dart';
import 'package:pharma_et/providers/LoginFormProvider.dart';
import 'package:pharma_et/providers/SignUpFormProvider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pharma_et/firebase_options.dart';
import 'package:pharma_et/providers/ThemeProvider.dart';
import 'package:pharma_et/router/router.dart';
import 'package:pharma_et/utils/Theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final prefs = await SharedPreferences.getInstance();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => ThemeProvider(prefs: prefs)),
        ChangeNotifierProvider(
          create: (context) => LocaleProvider(prefs: prefs),
        ),
        ChangeNotifierProvider(
          create: (context) => LoginFormProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SignUpFormProvider(),
        ),
      ],
      child: Builder(
        builder: (context) {
          final selectedTheme = Provider.of<ThemeProvider>(context).theme;
          final locale = Provider.of<LocaleProvider>(context).locale;
          return MaterialApp.router(
            routerConfig: AppRouter.router,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: selectedTheme == 'system'
                ? ThemeMode.system
                : selectedTheme == 'dark'
                    ? ThemeMode.dark
                    : ThemeMode.light,
            supportedLocales: L10n.locals,
            locale: Locale(locale),
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              AppLocalizations.delegate,
            ],
          );
        },
      ),
    ),
  );
}
