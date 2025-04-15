import 'package:flutter/material.dart';

class AuthFormfield extends StatelessWidget {
  final TextEditingController controller;
  final IconData icon;
  final String? Function(String?)? validator;
  final bool obscureText;
  final String label;
  final TextInputType keyboardType;
  const AuthFormfield(
      {super.key,
      required this.controller,
      required this.label,
      required this.icon,
      this.validator,
      this.obscureText = false,
      this.keyboardType = TextInputType.text});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
          labelText: label,
          hintText: label,
          labelStyle: Theme.of(context).textTheme.labelMedium,
          filled: true,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide.none,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 5, right: 8),
            child: Container(
                height: 40,
                width: 50,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                )),
          )),
    );
  }
}
