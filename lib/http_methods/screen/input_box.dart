import 'package:flutter/material.dart';

class InputBox extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool isRequired;
  final bool isNumber;
  final bool isDisabled;

  const InputBox({
    Key? key,
    required this.label,
    required this.controller,
    this.isNumber = false,
    this.isRequired = false,
    this.isDisabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String displayLabel = isRequired ? '$label *' : label;

    return SizedBox(
      width: 250,
      child: Container(
        margin: const EdgeInsets.all(5),
        child: TextFormField(
          controller: controller,
          enabled: !isDisabled,
          keyboardType: isNumber ? TextInputType.number : TextInputType.text,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            label: Text(displayLabel),
          ),
        ),
      ),
    );
  }
}
