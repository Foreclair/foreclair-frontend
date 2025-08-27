import 'package:flutter/cupertino.dart';
import 'package:foreclair/assets/colors/snsm_colors.dart';
import 'package:foreclair/src/data/models/logbook/event_attribute.dart';

import 'event_type_field.dart';

class EventType {
  final String key;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final List<EventAttribute> attributes;

  const EventType({
    required this.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.attributes,
  });

  static List<EventType> get values => [
    // 🔴 Intervention
    EventType(
      key: 'intervention',
      title: 'Intervention',
      subtitle: 'Create a new log entry',
      icon: CupertinoIcons.bell_fill,
      color: SNSMColors.rouge,
      attributes: [],
    ),
    // 🟢 Soin
    EventType(
      key: 'heal',
      title: 'Soin',
      subtitle: 'Create a new log entry',
      icon: CupertinoIcons.bandage_fill,
      color: const Color.fromARGB(255, 51, 128, 84),
      attributes: [],
    ),
    // 🟡 Prévention
    EventType(
      key: 'prevention',
      title: 'Prévention',
      subtitle: 'View past entries',
      icon: CupertinoIcons.bubble_left_bubble_right_fill,
      color: SNSMColors.jaune,
      attributes: [],
    ),
    // 🔄 Mouvement d'effectif
    EventType(
      key: 'rotation',
      title: "Mouvement d'effectif",
      subtitle: 'View past entries',
      icon: CupertinoIcons.refresh_thick,
      color: SNSMColors.bleuClair,
      attributes: [],
    ),
    // 🌅 Ouverture du poste
    EventType(
      key: 'opening',
      title: 'Ouverture du poste',
      subtitle: 'View past entries',
      icon: CupertinoIcons.sunrise_fill,
      color: SNSMColors.gris,
      attributes: [
        EventAttribute(
          key: "clockIn",
          title: "Ouverture du poste",
          type: EventTypeAttributes.clock,
        ),
        EventAttribute(
          key: "comment",
          title: "Commentaire",
          type: EventTypeAttributes.comment,
        ),
      ],
    ),
    // 🌇 Fermeture du poste
    EventType(
      key: 'closing',
      title: 'Fermeture du poste',
      subtitle: 'View past entries',
      icon: CupertinoIcons.sunset_fill,
      color: SNSMColors.gris,
      attributes: [
        EventAttribute(
          key: "clockOut",
          title: "Fermeture du poste",
          type: EventTypeAttributes.clock,
        ),
      ],
    ),
    // 🚩 Début de surveillance
    EventType(
      key: 'supervision_start',
      title: 'Début de surveillance',
      subtitle: 'See usage data',
      icon: CupertinoIcons.flag_fill,
      color: SNSMColors.bleuOcean,
      attributes: [],
    ),
    // 🏴 Fin de surveillance
    EventType(
      key: 'supervision_end',
      title: 'Fin de surveillance',
      subtitle: 'Customize preferences',
      icon: CupertinoIcons.flag_slash_fill,
      color: SNSMColors.bleuOcean,
      attributes: [],
    ),
  ];
}