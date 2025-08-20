import 'package:flutter/material.dart';
import 'package:foreclair/assets/colors/snsm_colors.dart';

class DashboardUserIcon extends StatelessWidget {
  final String firstName;
  final String lastName;

  const DashboardUserIcon({super.key, required this.firstName, required this.lastName});

  @override
  Widget build(BuildContext context) {
    final initials = '${firstName.isNotEmpty ? firstName[0] : ''}${lastName.isNotEmpty ? lastName[0] : ''}';

    return Align(
      alignment: Alignment.topRight,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [SNSMColors.bleuOcean, SNSMColors.bleuMarin],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            initials.toUpperCase(),
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
