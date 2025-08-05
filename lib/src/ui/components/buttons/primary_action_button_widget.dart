import 'package:blues/assets/colors/snsm_colors.dart';
import 'package:blues/assets/fonts/text_utils.dart';
import 'package:flutter/material.dart';

class PrimaryActionButtonWidget extends StatelessWidget {
  final Color color;
  final IconData? icon;
  final double? iconSize;
  final Color? iconColor;
  final String text;
  final TextStyle textStyle;
  final double width;
  final double height;
  final double borderRadius;
  final void Function()? onPressed;

  const PrimaryActionButtonWidget({
    super.key,
    this.color = SNSMColors.rouge,
    required this.text,
    this.textStyle = bodyMediumNeutralBold,
    this.width = double.infinity,
    this.height = 40,
    this.icon,
    this.iconSize = 20,
    this.iconColor = SNSMColors.blanc,
    this.onPressed,
    this.borderRadius = 50,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      width: width,
      height: height,
      decoration: ShapeDecoration(
        color: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(borderRadius))),
        shadows: const [BoxShadow(color: Color(0x3F000000), blurRadius: 4, offset: Offset(0, 4))],
      ),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(backgroundColor: color, minimumSize: Size(width, height)),
        child: Row(
          mainAxisAlignment: icon == null ? MainAxisAlignment.center : MainAxisAlignment.spaceBetween,
          children: [
            if (icon != null) Icon(icon, size: iconSize, color: iconColor),
            Text(text, style: textStyle),
            if (icon != null) const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
