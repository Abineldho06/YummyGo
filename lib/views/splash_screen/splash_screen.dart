import 'package:flutter/material.dart';
import 'package:yummygo/views/onboarding_screen/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 3)).then((value) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 900),
          pageBuilder: (_, animation, _) =>
              FadeTransition(opacity: animation, child: OnboardingScreen()),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'assets/images/logotext.png',
          width: MediaQuery.sizeOf(context).width * .7,
          height: MediaQuery.sizeOf(context).height * .7,
        ),
      ),
    );
  }
}
