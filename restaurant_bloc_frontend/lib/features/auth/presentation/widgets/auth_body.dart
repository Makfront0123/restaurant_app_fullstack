import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:restaurant_bloc_frontend/core/constants/icons.dart';
import 'package:restaurant_bloc_frontend/features/auth/presentation/widgets/auth_container.dart';

class AuthBody extends StatelessWidget {
  const AuthBody(
      {super.key, required this.child, this.showSocialButtons = true});
  final Widget child;
  final bool showSocialButtons;

  @override
  Widget build(BuildContext context) {
    final queryW = MediaQuery.of(context).size.width;
    final queryH = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AuthContainer(
                height: queryH * .73, width: queryW * .9, child: child),
            const SizedBox(height: 20),
            if (showSocialButtons) _buildSocialButtons(queryW),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialButtons(double queryW) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        AuthContainer(
            height: 80,
            width: queryW * .43,
            child: Center(
                child: SvgPicture.asset(
              IconsSvg.facebook,
              colorFilter: const ColorFilter.mode(Colors.blue, BlendMode.srcIn),
            ))),
        AuthContainer(
            height: 80,
            width: queryW * .43,
            child: Center(
                child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: SvgPicture.asset(IconsSvg.google),
            ))),
      ],
    );
  }
}