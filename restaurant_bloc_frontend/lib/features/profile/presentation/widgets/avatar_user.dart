import 'package:flutter/material.dart';
import 'package:restaurant_bloc_frontend/core/constants/images.dart';

class AvatarUser extends StatelessWidget {
  const AvatarUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        const CircleAvatar(
          radius: 100,
          backgroundImage: AssetImage(Images.user),
        ),
        Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black
                .withOpacity(0.5), // Color con opacidad para el overlay
          ),
          child: Icon(
            Icons.camera_alt_outlined,
            size: 60,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }
}
