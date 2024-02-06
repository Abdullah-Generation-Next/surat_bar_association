import 'package:flutter/material.dart';

class SplashAgain extends StatefulWidget {
  const SplashAgain({super.key});

  @override
  State<SplashAgain> createState() => _SplashAgainState();
}

class _SplashAgainState extends State<SplashAgain> {
  @override
  void initState() {
    super.initState();
    _navigateToLogin();
  }

  _navigateToLogin() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    Navigator.pushNamed(context, '/homePage');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Center(
        child: CircularProgressIndicator(
          color: Colors.grey,
        ),
      ),
    );
  }
}
