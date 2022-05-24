import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    this.controller,
    required this.keyboardType,
    required this.inputAction,
    required this.autoCorrect,
    required this.obscureText,
    this.icon,
    this.labelText,
    this.hintText,
    this.node
  }) : super(key: key);
  final TextInputType? keyboardType;
  final TextInputAction? inputAction;
  final TextEditingController? controller;
  final Icon? icon;
  final FocusNode? node;

  final bool? autoCorrect;
  final bool? obscureText;
  final String? labelText;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        color: Colors.blueGrey,
      ),
      child: TextField(
        textAlign: TextAlign.start,
        controller: controller,
        keyboardType: keyboardType,
        textInputAction: inputAction,
        autocorrect: autoCorrect!,
        focusNode: node,
        obscureText: obscureText!,
        style: const TextStyle(
          color: Colors.white,
        ),
        cursorColor: Colors.white,
        decoration: InputDecoration(
          prefixIcon: icon,
          prefixIconColor: Colors.white,
          iconColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          labelText: labelText,
          hintStyle: const TextStyle(
            color: Colors.white,
          ),
          hintText: hintText,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          focusedBorder:   const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(1.0)),
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}