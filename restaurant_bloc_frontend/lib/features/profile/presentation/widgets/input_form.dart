import 'package:flutter/material.dart';
import 'package:restaurant_bloc_frontend/core/utils/validator_auth.dart';

class InputForm extends StatelessWidget {
  const InputForm(
      {super.key, required this.controller, this.titleForm, this.icon});

  final TextEditingController controller;
  final String? titleForm;
  final IconData? icon;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          labelText: titleForm,
          hintText: titleForm,
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
      validator: (value) => Validators.validateEmail(value),
      keyboardType: TextInputType.emailAddress,
    );
  }
}
