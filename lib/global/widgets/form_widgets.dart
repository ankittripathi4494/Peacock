import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormWidget {
  static textFieldFormWidget(BuildContext context,
      {TextEditingController? controller,
      TextInputType? keyboardType,
      List<TextInputFormatter>? inputFormatters,
      bool? enabled,
      IconData? normalIcon,
      IconData? suffixIcon,
      bool? obscureText,
      String? obscuringCharacter,
      Widget? suffix,
      Widget? prefix,
      String? labelText}) {
    return TextFormField(
      enabled: enabled,
      controller: controller,
      obscureText: (obscureText != null) ? obscureText : false,
      obscuringCharacter:
          (obscuringCharacter != null) ? obscuringCharacter : '•',
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      style: const TextStyle(
          color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        prefix: prefix,
        prefixIcon: Icon(normalIcon),
        prefixIconColor: Colors.white,
        suffixIcon: (suffixIcon != null) ? Icon(suffixIcon) : null,
        suffixIconColor: Colors.white,
        suffix: suffix,
        labelText: labelText,
        labelStyle: const TextStyle(
            color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.white, width: 2)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.white, width: 2)),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.grey, width: 2)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.white, width: 2)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.white, width: 2)),
      ),
    );
  }
}
