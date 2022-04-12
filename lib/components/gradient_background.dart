import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  final dynamic child;

  const GradientBackground({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(

                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [
                  0.1,
                  0.5,
                  0.9
                ],
                colors: [
                  Colors.greenAccent,
                  Colors.greenAccent,
                  Colors.cyan])),
        child: child
    );
  }
}
