import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

TextFormField textformfield(
  TextEditingController ctrl,
  RegExp? regexpcon, {
  TextInputType? keyboardtype,
  String? Function(String?)? validator,
  String? hintText,
}) {
  return TextFormField(
    controller: ctrl,
    maxLines: 1,
    keyboardType: keyboardtype,
    inputFormatters: [
      FilteringTextInputFormatter.allow(regexpcon ?? ""),
    ],
    autovalidateMode: AutovalidateMode.onUserInteraction,
    decoration: InputDecoration(
      hintText: hintText,
      border: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.blue,
          width: 5,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.purple,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.black87,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
    ),
    
    validator: validator,
  );
}
