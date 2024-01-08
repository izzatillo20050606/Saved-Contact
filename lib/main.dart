import 'package:flutter/material.dart';

import 'app/dashboard/dashboard_screen.dart';
import 'utils/objectbox.dart';

late final Objectbox objectbox;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  objectbox = await Objectbox.create();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const DashboardScreen());
  }
}
