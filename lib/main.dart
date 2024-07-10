import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:note_app/filtering.dart';
import 'package:note_app/screen/auth/home.dart';
import 'package:note_app/screen/auth/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("User is currently signed out!"),
            duration: Duration(milliseconds: 300),
          ),
        );

        print('==============================User is currently signed out!');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("User is signed in!${user.email}'"),
            duration: Duration(milliseconds: 300),
          ),
        );

        print('==============================User is signed in!${user.email}');
      }
    });
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            backgroundColor: const Color.fromARGB(255, 182, 61, 132),
            titleTextStyle: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w600),
            iconTheme: IconThemeData(color: Colors.white),
            
          ),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: false,
        ),
        home: FilteringPage(),
        // (FirebaseAuth.instance.currentUser != null &&
        //         FirebaseAuth.instance.currentUser!.emailVerified)
        //     ? const Home()
        //     : const Login(),
      ),
    );
  }
}
