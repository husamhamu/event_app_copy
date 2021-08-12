import 'package:event_app/app/authentication-sign_in/sign_in_view.dart';
import 'package:event_app/app/home/home_view.dart';
import 'package:event_app/app/top_level_providers/locale_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: context.watch<LocaleProvider>().locale,
      supportedLocales: [
        const Locale('en'),
        const Locale('tr'),
        const Locale('de'),
      ],
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      title: 'Event App',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Consumer<User?>(
        builder: (_, user, __) {
          if (user == null) {
            return SignInView();
          } else {
            return HomeView();
          }
          // return HomeView();
        },
      ),
    );
  }
}
