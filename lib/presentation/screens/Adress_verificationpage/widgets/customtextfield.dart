import 'package:flutter/material.dart';
import 'package:arthor/core/colors.dart';

class CustomTextfieldVerification extends StatelessWidget {
  final String label;
  final bool isRequired;
  final String? initialValue;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final TextInputType keyboardType;
  final int maxLines;

  const CustomTextfieldVerification({
    super.key,
    required this.label,
    this.isRequired = false,
    this.initialValue,
    this.onChanged,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
  });

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
    return TextFormField(
      initialValue: initialValue,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: _decoration(context),
      onChanged: onChanged,
      validator: validator,
    );
  }
}
