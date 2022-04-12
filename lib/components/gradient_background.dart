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
                  Color.fromRGBO(41, 255, 198, 1),
                  Color.fromRGBO (32, 227, 178, 1),
                  Color.fromRGBO(12, 235, 235, 1),
                  ])),
        child: child
    );
  }
}
