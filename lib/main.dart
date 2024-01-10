
import 'package:flutter/material.dart';
import 'package:study_table/router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://eefooxntbqcezshwrpid.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImVlZm9veG50YnFjZXpzaHdycGlkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDQyNTM4NjcsImV4cCI6MjAxOTgyOTg2N30.KK6VfWolIh2LPZDoUIs-7ceW_Jo7ssFq6Mfxqe9PvLo',
  );
  runApp(const MyApp());
  
}

final supabase = Supabase.instance.client;
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return
     MaterialApp.router(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}

//  NeumorphicApp(
//       debugShowCheckedModeBanner: false,
//     // themeMode: ThemeMode.dark,
//      home: HomePage(),
//     );
