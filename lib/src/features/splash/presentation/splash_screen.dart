import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  final VoidCallback onInitializationComplete;
  const SplashScreen({super.key, required this.onInitializationComplete});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2))
        .then((_) => widget.onInitializationComplete());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Chatify",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: Colors.white
          // backgroundColor: const Color.fromRGBO(36, 35, 49, 1.0),
          // scaffoldBackgroundColor: const Color.fromRGBO(36, 35, 49, 1.0),
          ),
      home: Scaffold(
        body: Center(
          child: SizedBox(
            height: 230,
            width: 230,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/images/logo.svg', height: 175, width: 175,),
                  const Text('Notee', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
