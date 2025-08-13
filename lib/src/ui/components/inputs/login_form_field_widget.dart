import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../assets/colors/snsm_colors.dart';
import '../../../../assets/fonts/text_utils.dart';

class LoginFormField extends StatelessWidget {
  final String? label;
  final String hint;
  final Color color;
  final TextStyle textStyle;
  final double width;
  final double height;
  final bool capital;
  final bool password;
  final TextEditingController controller;
  final IconData icon;
  final String? Function(String?)? validator;
  final bool readOnly;
  final List<String>? autofillHints;

  const LoginFormField({
    super.key,
    this.label,
    required this.hint,
    this.color = SNSMColors.bleuMarin,
    this.textStyle = bodySmall,
    this.width = double.infinity,
    this.height = 0,
    this.icon = CupertinoIcons.check_mark_circled,
    required this.controller,
    this.password = false,
    this.capital = false,
    this.validator,
    this.readOnly = false,
    this.autofillHints,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        readOnly: readOnly,
        autofillHints: autofillHints,
        textCapitalization: capital ? TextCapitalization.words : TextCapitalization.none,
        controller: controller,
        style: textStyle,
        cursorColor: color,
        obscureText: password ? true : false,
        keyboardType: password ? TextInputType.visiblePassword : TextInputType.emailAddress,
        decoration: InputDecoration(
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(10.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: color),
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: color),
            borderRadius: BorderRadius.circular(10.0),
          ),
          labelText: label ?? hint,
          // Floating label text
          labelStyle: TextStyle(color: color),
          prefixIcon: Icon(icon, color: color),
          floatingLabelBehavior: label == null ? FloatingLabelBehavior.never : FloatingLabelBehavior.always,
        ),
        validator: validator,
      ),
    );
  }
}
