import 'dart:ui';

import 'package:flutter/material.dart';

import '../global.dart';


class InputField extends StatelessWidget {
  final String hintText;
  final  TextEditingController controller;
  final TextInputType textInputType;
  final String lableText;
  final bool password;
  final  d_color;
  const InputField({super.key,required this.password, required this.hintText,required this.controller, required this.textInputType, required this.lableText,this.d_color});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 400,
        ),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: TextFormField(
            validator: (val){
              if(val!.isEmpty)
                {
                  return "Field Required";
                }
            },
            style: TextStyle(color: d_color),
            keyboardType: textInputType,
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
              ),
              hintText: hintText,
              labelText: lableText
            ),
          ),
        ),
      ),
    );
  }
}
