import 'package:flutter/material.dart';
import 'package:study_table/notification/notification_service.dart';
import 'package:study_table/pages/Show_offer.dart';
import 'package:study_table/pages/add_offer.dart';
import 'package:study_table/pages/log.dart';
import 'package:study_table/pages/splash.dart';
import 'package:study_table/pages/update_show_table.dart';
import 'package:study_table/router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://eefooxntbqcezshwrpid.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImVlZm9veG50YnFjZXpzaHdycGlkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDQyNTM4NjcsImV4cCI6MjAxOTgyOTg2N30.KK6VfWolIh2LPZDoUIs-7ceW_Jo7ssFq6Mfxqe9PvLo',
  );
  await NotificationService.initializeNottification();
  runApp(const MyApp());

}


final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      home: AddOffer(),
      // localizationsDelegates: [
      //           S.delegate,
      //           GlobalMaterialLocalizations.delegate,
      //           GlobalWidgetsLocalizations.delegate,
      //           GlobalCupertinoLocalizations.delegate,
      //       ],
      //       supportedLocales: S.delegate.supportedLocales,
    );
  }
}



