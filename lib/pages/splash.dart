import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:study_table/pages/signup.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    navigateToNextScreen();
  }

  void navigateToNextScreen() async {
    await Future.delayed(Duration(seconds: 5)); // Delay for 3 seconds

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SignUpPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(decoration: BoxDecoration(
              // color: Color(0xff8D376F),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                tileMode: TileMode.clamp,
                colors: [
                  Color(0xff5AB8B3),
                  Color(0xffDF6937),
                ],
              ),
            ),
        child: Center(child: Image.asset("assets/hone.png"))),
    );
  }
}
