import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../colors/snsm_colors.dart';

final TextStyle titleLarge = TextStyle(
  fontSize: 32,
  fontWeight: FontWeight.bold,
  fontFamily: GoogleFonts.poppins().fontFamily,
);
final TextStyle titleLargeNeutral = TextStyle(
  fontSize: 32,
  fontWeight: FontWeight.bold,
  color: SNSMColors.blanc,
  fontFamily: GoogleFonts.poppins().fontFamily,
);

const TextStyle titleMedium = TextStyle(fontSize: 22, fontWeight: FontWeight.bold);
const TextStyle titleMediumNeutral = TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: SNSMColors.blanc);

const TextStyle titleIntro = TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: SNSMColors.bleuOcean);

const TextStyle bodyLarge = TextStyle(fontSize: 19, fontWeight: FontWeight.w500);
const TextStyle bodyLargeBold = TextStyle(fontSize: 19, fontWeight: FontWeight.bold);
const TextStyle bodyLargeNeutral = TextStyle(fontSize: 19, fontWeight: FontWeight.w500, color: SNSMColors.blanc);
const TextStyle bodyLargeNeutralBold = TextStyle(fontSize: 19, fontWeight: FontWeight.w900, color: SNSMColors.blanc);

const TextStyle bodyMedium = TextStyle(fontSize: 16, fontWeight: FontWeight.w500);
const TextStyle bodyMediumBold = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
const TextStyle bodyMediumNeutral = TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: SNSMColors.blanc);
const TextStyle bodyMediumNeutralBold = TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: SNSMColors.blanc);

const TextStyle bodySmall = TextStyle(fontSize: 14, fontWeight: FontWeight.w400);
const TextStyle bodySmallBold = TextStyle(fontSize: 14, fontWeight: FontWeight.w900);
const TextStyle bodySmallBoldNeutral = TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: SNSMColors.blanc);
const TextStyle bodySmallNeutral = TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: SNSMColors.blanc);
const TextStyle bodySmallError = TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.redAccent);

const TextStyle label = TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.grey);
