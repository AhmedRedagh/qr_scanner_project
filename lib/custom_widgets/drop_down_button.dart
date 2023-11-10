import 'package:flutter/material.dart';

class DropDownFilter extends StatelessWidget {
  final String value;

  final List<DropdownMenuItem<String>> items;
  final void Function(String?) onChanged;

  const DropDownFilter(
      {super.key,
      required this.value,
      required this.items,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.black, width: 2)),
        child: Center(
            child: DropdownMenu<String>(
          onSelected: (value) => onChanged(value),
          dropdownMenuEntries: [
            DropdownMenuEntry(value: value, label: 'Arabic'),
            DropdownMenuEntry(value: value, label: 'English'),
          ],
        )));
  }
}
