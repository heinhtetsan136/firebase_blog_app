import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_blog_app/data/google_login.dart';
import 'package:firebase_blog_app/screen/home.dart';
import 'package:firebase_blog_app/screen/login/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'screen/animate_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options:
    DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  User? _user;
  bool isJailed = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    listenAutState((user) {
      setState(() {
        _user = user;
      });
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return isJailed
        ? MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text(
            "This app is not allowed on jailbroken devices.",
          ),
        ),
      ),
    )
        : MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: .fromSeed(
          seedColor: Colors.deepPurple,
        ),
      ),
      home: _user == null
          ? LoginScreen()
          : Home(),
    );
  }
}
