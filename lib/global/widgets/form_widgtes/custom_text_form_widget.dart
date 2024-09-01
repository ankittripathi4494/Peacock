import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  final bool enabled;
  final TextEditingController controller;
  final bool obscureText;
  final String obscuringCharacter;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;
  final Widget? prefix;
  final IconData? normalIcon;
  final IconData? suffixIcon;
  final Widget? suffix;
  final String? labelText;
  final String? errorText;
  final int? maxLength;

  const CustomTextFormField({
    super.key,
    this.enabled = true,
    required this.controller,
    this.obscureText = false,
    this.obscuringCharacter = '•',
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.onChanged,
    this.prefix,
    this.normalIcon,
    this.suffixIcon,
    this.suffix,
    this.labelText,
    this.errorText,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      controller: controller,
      obscureText: obscureText,
      obscuringCharacter: obscuringCharacter,
      keyboardType: keyboardType,
      maxLength: maxLength,
      inputFormatters: inputFormatters,
      onChanged: onChanged,
      style: const TextStyle(
          color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        prefix: prefix,
        prefixIcon: normalIcon != null ? Icon(normalIcon) : null,
        prefixIconColor: Colors.white,
        suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
        suffixIconColor: Colors.white,
        suffix: suffix,
        labelText: labelText,
        counterText: '',
        errorText: errorText,
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
            borderSide: const BorderSide(color: Colors.deepOrange, width: 2)),
      ),
    );
  }
}
