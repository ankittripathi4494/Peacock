import 'package:flutter/material.dart';

class CustomCheckboxButtons<T> extends StatelessWidget {
  final List<T> items;
  final List<T> selectedValues;
  final Function(T) onChanged;
  final String Function(T) getTitle; // Function to extract title from item

  const CustomCheckboxButtons({
    super.key,
    required this.items,
    required this.selectedValues,
    required this.onChanged,
    required this.getTitle, // Required parameter to extract title
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: items
              .map((item) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ChoiceChip(
                      label: Text(getTitle(item)), // Use getTitle to extract title
                      selected: selectedValues.contains(item),
                      onSelected: (selected) {
                        if (selected) {
                          onChanged(item);
                        }
                      },
                      selectedColor: Colors.deepOrange,
                      backgroundColor: Colors.grey.shade300,
                      labelStyle: TextStyle(
                        color: selectedValues.contains(item)
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
