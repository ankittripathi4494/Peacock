import 'package:flutter/material.dart';

class CustomRadioButtons<T> extends StatelessWidget {
  final List<T> items;
  final T? selectedValue;
  final Function(T?)? onChanged;
  final String Function(T) getTitle; // Callback to extract the title
  final String? errorText;

  const CustomRadioButtons(
      {super.key,
      required this.items,
      this.selectedValue,
      this.onChanged,
      required this.getTitle, // Required callback
      this.errorText});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: items
                .map((item) => RadioMenuButton<T>(
                      style: const ButtonStyle(
                          foregroundColor: WidgetStatePropertyAll(Colors.white),
                          iconColor: WidgetStatePropertyAll(Colors.white),
                          textStyle: WidgetStatePropertyAll(TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold))),
                      value: item,
                      groupValue: selectedValue,
                      onChanged: onChanged,
                      child: Text(
                        getTitle(item),
                      ), // Use the callback to get the title
                    ))
                .toList(),
          ),
        ),
        const SizedBox(height: 5,),
        Text(
          errorText ?? '',
          style: const TextStyle(color: Colors.deepOrange),
        )
      ],
    );
  }
}
