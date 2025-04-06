import 'package:flutter/material.dart';

class AuthContainer extends StatelessWidget {
  final Widget child;
  final double? height;
  final double? width;

  const AuthContainer({
    super.key,
    required this.child,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).primaryColor,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 1),
            spreadRadius: 1,
            blurRadius: 1,
            color: Colors.black.withOpacity(.2),
          )
        ],
      ),
      child: child,
    );
  }
}
