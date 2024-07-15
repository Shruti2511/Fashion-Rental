import 'package:flutter/material.dart';
import 'package:hackathon/firebase_options.dart';
import 'package:hackathon/startingPage.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Online-Rental',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[200], 
      ),
      home: StartingPage(),
      debugShowCheckedModeBanner: false, 
    );
  }
}

