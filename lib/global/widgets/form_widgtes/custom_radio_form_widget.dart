import 'package:flutter/material.dart';

class CustomRadioButtons<T> extends StatelessWidget {
  final List<T> items;
  final T? selectedValue;
  final Function(T?)? onChanged;
  final String Function(T) getTitle; // Callback to extract the title

  const CustomRadioButtons({
    super.key,
    required this.items,
    this.selectedValue,
    this.onChanged,
    required this.getTitle, // Required callback
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: items
            .map((item) => RadioMenuButton<T>(
                  value: item,
                  groupValue: selectedValue,
                  onChanged: onChanged,
                  child: Text(getTitle(item)), // Use the callback to get the title
                ))
            .toList(),
      ),
    );
  }
}
