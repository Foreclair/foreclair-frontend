import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../assets/colors/snsm_colors.dart';
import '../../../../assets/fonts/text_utils.dart';

class LoginFormField extends TextFormField {
  LoginFormField({
    super.key,
    String? label,
    required String hint,
    Color color = SNSMColors.bleuMarin,
    TextStyle textStyle = bodySmall,
    double width = double.infinity,
    double height = 0,
    bool capital = false,
    bool password = false,
    required TextEditingController super.controller,
    IconData icon = CupertinoIcons.check_mark_circled,
    super.validator,
    super.readOnly,
    List<String>? super.autofillHints,
    TextInputAction super.textInputAction = TextInputAction.next,
    super.onFieldSubmitted,
  }) : super(
    obscureText: password,
    keyboardType: password ? TextInputType.visiblePassword : TextInputType.emailAddress,
    textCapitalization: capital ? TextCapitalization.words : TextCapitalization.none,
    style: textStyle,
    cursorColor: color,
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
      labelStyle: TextStyle(color: color),
      prefixIcon: Icon(icon, color: color),
      floatingLabelBehavior: label == null ? FloatingLabelBehavior.never : FloatingLabelBehavior.always,
    ),
  );
}
