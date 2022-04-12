import 'package:flutter/material.dart';

class OpaqueContainerChild extends StatelessWidget {

  final dynamic child;

  const OpaqueContainerChild({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
      padding: EdgeInsets.symmetric(vertical: 15,horizontal: 20),
      decoration: const BoxDecoration(
          color: Color.fromRGBO(255,255,255,0.5),
          borderRadius: BorderRadius.all(Radius.circular(15))),
      width: MediaQuery.of(context).size.width,
      child: child,
    );
  }
}
