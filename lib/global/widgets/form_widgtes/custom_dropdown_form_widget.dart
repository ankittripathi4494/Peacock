import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class CustomDropdown<T> extends StatelessWidget {
  final List<T> items;
  final String hint;
  final T? selectedValue;
  final String? errorText;
  final Function(T?)? onChanged;
  final String Function(T) getTitle; // Callback to extract the title

  const CustomDropdown({
    super.key,
    required this.items,
    required this.hint,
    this.selectedValue,
    this.errorText,
    this.onChanged,
    required this.getTitle, // Required callback
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<T>(
      isExpanded: true,
      decoration: InputDecoration(
        errorText: errorText,
        errorStyle: const TextStyle(color: Colors.deepOrange),
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(15),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(15),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.deepOrange),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      hint: Text(
        hint,
        style: const TextStyle(fontSize: 14, color: Colors.white),
      ),
      items: items
          .map((item) => DropdownMenuItem<T>(
                value: item,
                child: Text(
                  getTitle(item), // Use the callback to get the title
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                ),
              ))
          .toList(),
      onChanged: onChanged,
      value: selectedValue,
      buttonStyleData: const ButtonStyleData(
        padding: EdgeInsets.only(right: 8),
      ),
      iconStyleData: const IconStyleData(
        icon: Icon(
          Icons.arrow_drop_down,
          color: Colors.white,
        ),
        iconSize: 24,
      ),
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
              colors: [Colors.deepPurple, Colors.blue],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      menuItemStyleData: const MenuItemStyleData(
        padding: EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }
}
