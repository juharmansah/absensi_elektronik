import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  int currentImageIndex = 0;
  List<String> imagePaths = ['assets/logo.png', 'assets/kominfo_logo.png'];

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration(seconds: 4), // Menyesuaikan waktu penundaan total
      () => Navigator.pushReplacementNamed(context, '/login'),
    );
    _startAnimation();
  }

  void _startAnimation() {
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        currentImageIndex = (currentImageIndex + 1) % imagePaths.length;
        _startAnimation();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          color: Color(0xFF61F882),
        ),
        Center(
          child: Image.asset(
            imagePaths[currentImageIndex],
            key: ValueKey<int>(currentImageIndex),
            width: 300, 
            height: 300,
          ),
        ),
      ],
    );
  }
}
