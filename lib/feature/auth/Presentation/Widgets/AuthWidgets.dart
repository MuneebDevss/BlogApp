
import 'package:flutter/material.dart';


class AuthField extends StatelessWidget {
  const AuthField({
    super.key,
    required this.hintText,required this.controllers, this.isObsecure=false});
  final TextEditingController controllers;
  final bool isObsecure;
  final String hintText;
  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      controller: controllers,
      validator: (value)
      {
        if(hintText.isEmpty)
        {
          return "$hintText is empty";
        }
        return null;
      },
      obscureText: isObsecure,
      decoration: InputDecoration(
        hintText: hintText,
      ),
    );
  }
}
