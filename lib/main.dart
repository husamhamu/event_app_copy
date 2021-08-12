import 'dart:js';

import 'package:event_app/app/top_level_providers/locale_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/app.dart';
import 'package:event_app/services/firebase_auth_service.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          Provider(
            create: (_) => FirebaseAuthService(),
          ),
          StreamProvider<User?>(
            initialData: null,
            create: (context) =>
                context.read<FirebaseAuthService>().onAuthStateChanged,
          ),
          ChangeNotifierProvider<LocaleProvider>(
            create: (context) => LocaleProvider(),
          ),
        ],
        child: MyApp(),
      ),
    );
