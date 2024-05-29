import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notee/src/features/note/presentation/screens/home_screen.dart';
import 'package:notee/src/features/splash/presentation/splash_screen.dart';

void main() {
  runApp( SplashScreen(onInitializationComplete: (){
    runApp( const ProviderScope(child: MyApp()));
  }));
}

//TODO: Add Local Auth (Biometric)
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen()
    );
  }
}

