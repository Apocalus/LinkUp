import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:linkup/pages/splash_screen.dart';
import 'package:linkup/services/auth/auth_gate.dart';
// import 'package:linkup/auth/login_or_register.dart';
import 'package:linkup/firebase_options.dart';
import 'package:linkup/themes/light_mode.dart';
import 'package:linkup/themes/theme_provider.dart';
// import 'pages/login_page.dart';
import 'package:provider/provider.dart';

//initializing firebase
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: const AuthGate(),
      home: const SplashScreen(),
      theme: Provider.of<ThemeProvider>(context).themeData,
      // theme: ThemeData.light(),
      // darkTheme: ThemeData.dark(),
      // themeMode: Provider.of<ThemeProvider>(context).isDarkMode ? ThemeMode.dark : ThemeMode.light,
    );
  }
}