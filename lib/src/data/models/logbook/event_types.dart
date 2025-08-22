import 'package:flutter/cupertino.dart';

import '../../../../assets/colors/snsm_colors.dart';

enum EventType {
  intervention(
    title: 'Intervention',
    subtitle: 'Create a new log entry',
    icon: CupertinoIcons.bell_fill,
    color: SNSMColors.rouge,
  ),
  heal(
    title: 'Soin',
    subtitle: 'Create a new log entry',
    icon: CupertinoIcons.bandage_fill,
    color: Color.fromARGB(255, 51, 128, 84),
  ),
  prevention(
    title: 'Prévention',
    subtitle: 'View past entries',
    icon: CupertinoIcons.bubble_left_bubble_right_fill,
    color: SNSMColors.jaune,
  ),
  rotation(
    title: 'Mouvement d\'effectif',
    subtitle: 'View past entries',
    icon: CupertinoIcons.refresh_thick,
    color: SNSMColors.bleuClair,
  ),
  ouverture(
    title: 'Ouverture du poste',
    subtitle: 'View past entries',
    icon: CupertinoIcons.sunrise_fill,
    color: SNSMColors.gris,
  ),
  fermeture(
    title: 'Fermeture du poste',
    subtitle: 'View past entries',
    icon: CupertinoIcons.sunset_fill,
    color: SNSMColors.gris,
  ),
  dsurveillance(
    title: 'Début de surveillance',
    subtitle: 'See usage data',
    icon: CupertinoIcons.flag_fill,
    color: SNSMColors.bleuOcean,
  ),
  fsurveillance(
    title: 'Fin de surveillance',
    subtitle: 'Customize preferences',
    icon: CupertinoIcons.flag_slash_fill,
    color: SNSMColors.bleuOcean,
  ),
  testo(
    title: 'Test',
    subtitle: 'Create a new log entry',
    icon: CupertinoIcons.checkmark_seal_fill,
    color: SNSMColors.grisClair,
  ),
  maintenance(
    title: 'Maintenance',
    subtitle: 'Create a new log entry',
    icon: CupertinoIcons.wrench_fill,
    color: SNSMColors.bleuMarin,
  );

  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  const EventType({required this.title, required this.subtitle, required this.icon, required this.color});
}
