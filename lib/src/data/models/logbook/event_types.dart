import 'package:flutter/cupertino.dart';
import 'package:foreclair/assets/colors/snsm_colors.dart';
import 'package:foreclair/src/data/models/logbook/attribute.dart';

import 'event_type_attribute.dart';

class EventType {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final List<Attribute> attributes;

  const EventType({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.attributes,
  });

  // 🔴 Intervention
  static final intervention = EventType(
    title: 'Intervention',
    subtitle: 'Create a new log entry',
    icon: CupertinoIcons.bell_fill,
    color: SNSMColors.rouge,
    attributes: [],
  );

  // 🟢 Soin
  static final heal = EventType(
    title: 'Soin',
    subtitle: 'Create a new log entry',
    icon: CupertinoIcons.bandage_fill,
    color: const Color.fromARGB(255, 51, 128, 84),
    attributes: [],
  );

  // 🟡 Prévention
  static final prevention = EventType(
    title: 'Prévention',
    subtitle: 'View past entries',
    icon: CupertinoIcons.bubble_left_bubble_right_fill,
    color: SNSMColors.jaune,
    attributes: [],
  );

  // 🔄 Mouvement d'effectif
  static final rotation = EventType(
    title: "Mouvement d'effectif",
    subtitle: 'View past entries',
    icon: CupertinoIcons.refresh_thick,
    color: SNSMColors.bleuClair,
    attributes: [],
  );

  // 🌅 Ouverture du poste
  static final ouverture = EventType(
    title: 'Ouverture du poste',
    subtitle: 'View past entries',
    icon: CupertinoIcons.sunrise_fill,
    color: SNSMColors.gris,
    attributes: [
      Attribute(key: "clockIn", title: "Ouverture du poste", type: EventTypeAttributes.clock),
      Attribute(key: "comment", title: "Commentaire", type: EventTypeAttributes.comment),
    ],
  );

  // 🌇 Fermeture du poste
  static final fermeture = EventType(
    title: 'Fermeture du poste',
    subtitle: 'View past entries',
    icon: CupertinoIcons.sunset_fill,
    color: SNSMColors.gris,
    attributes: [Attribute(key: "clockOut", title: "Fermeture du poste", type: EventTypeAttributes.clock)],
  );

  // 🚩 Début de surveillance
  static final dsurveillance = EventType(
    title: 'Début de surveillance',
    subtitle: 'See usage data',
    icon: CupertinoIcons.flag_fill,
    color: SNSMColors.bleuOcean,
    attributes: [],
  );

  // 🏴 Fin de surveillance
  static final fsurveillance = EventType(
    title: 'Fin de surveillance',
    subtitle: 'Customize preferences',
    icon: CupertinoIcons.flag_slash_fill,
    color: SNSMColors.bleuOcean,
    attributes: [],
  );

  static List<EventType> get values => [
    intervention,
    heal,
    prevention,
    rotation,
    ouverture,
    fermeture,
    dsurveillance,
    fsurveillance,
  ];
}
