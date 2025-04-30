import 'dart:io';

import 'package:flutter/material.dart';
import 'package:restaurant_bloc_frontend/core/constants/images.dart';

class AvatarUser extends StatelessWidget {
  final File? image;
  final VoidCallback onTap;

  const AvatarUser({super.key, required this.image, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CircleAvatar(
          radius: 100,
          backgroundImage: image != null
              ? FileImage(image!)
              : const AssetImage(Images.user) as ImageProvider,
        ),
        InkWell(
          onTap: onTap,
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black.withOpacity(0.5),
            ),
            child: Icon(
              Icons.camera_alt_outlined,
              size: 60,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
