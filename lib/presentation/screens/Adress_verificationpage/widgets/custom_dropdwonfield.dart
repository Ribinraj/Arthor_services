import 'package:flutter/material.dart';
import 'package:arthor/core/colors.dart';

class CustomDropdownField extends StatelessWidget {
  final String label;
  final bool isRequired;
  final List<String> items;
  final String? value;
  final ValueChanged<String?>? onChanged;
  final FormFieldValidator<String>? validator;

  const CustomDropdownField({
    Key? key,
    required this.label,
    required this.items,
    this.value,
    this.onChanged,
    this.validator,
    this.isRequired = false,
  }) : super(key: key);

  InputDecoration _decoration(BuildContext context) {
    return InputDecoration(
      labelText: isRequired ? '$label *' : label,
      labelStyle: TextStyle(color: Appcolors.kblackcolor.withOpacity(0.7)),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Appcolors.kbordercolor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: Appcolors.kbordercolor.withOpacity(0.5),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Appcolors.kprimarycolor,
          width: 2,
        ),
      ),
      filled: true,
      fillColor: Appcolors.kwhitecolor,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: _decoration(context),
      items: items
          .map(
            (e) => DropdownMenuItem(
              value: e,
              child: Text(e),
            ),
          )
          .toList(),
      value: value,
      onChanged: onChanged,
      validator: validator,
      isExpanded: true,
    );
  }
}
