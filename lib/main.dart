import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/auth/login_or_register.dart';
import 'package:fooddeliveryapp/themes/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:fooddeliveryapp/models/restaurant.dart';

void main() {
  runApp(
  MultiProvider(
    providers: [
      // Theme provider
      ChangeNotifierProvider(create: (context) => ThemeProvider()),

      // Restaurant provider
      ChangeNotifierProvider(create: (context) => Restaurant()),
    ],
    child: const MyApp(),
  ), // MultiProvider
);

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home : const LoginOrRegister(),
      theme: Provider.of<ThemeProvider>(context).themeData,
      
    );
  }
}

