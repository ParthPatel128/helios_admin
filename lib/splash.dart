import 'package:flutter/material.dart';

import 'auth/login_page.dart';
import 'constant/assets_path.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff023034),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 180),
            child: Image.asset(splashLogo),
          ),
          const Text(
            "Welcome Admin",
            style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: 20,
                decoration: TextDecoration.underline,
                letterSpacing: 0.5,
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2),() {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage(),));
    },);
  }
}
