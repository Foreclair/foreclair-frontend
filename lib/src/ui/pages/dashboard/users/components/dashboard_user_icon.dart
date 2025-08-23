import 'package:flutter/material.dart';
import 'package:foreclair/assets/colors/snsm_colors.dart';
import 'package:foreclair/src/data/services/authentication/auth_service.dart';
import 'package:foreclair/src/ui/views/authentication/login_view.dart';
import 'package:foreclair/utils/logs/logger_utils.dart';

class DashboardUserIcon extends StatelessWidget {
  final String firstName;
  final String lastName;

  const DashboardUserIcon({super.key, required this.firstName, required this.lastName});

  @override
  Widget build(BuildContext context) {
    AuthService authService = AuthService.instance;
    final initials = '${firstName.isNotEmpty ? firstName[0] : ''}${lastName.isNotEmpty ? lastName[0] : ''}';

    return Align(
      alignment: Alignment.topRight,
      child: GestureDetector(
        onTap: () {
          authService.disconnect().then((_) => logger.i('User disconnected'));
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LoginView()));
        },
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
      ),
    );
  }
}
