import 'package:flutter/material.dart';
import 'package:foreclair/src/data/models/users/user_model.dart';
import 'package:foreclair/utils/units/size_utils.dart';

import '../../pages/dashboard/users/components/dashboard_user_icon.dart';

class HeaderLayout extends StatelessWidget {
  final UserModel user;
  final String title;
  final String subtitle;

  const HeaderLayout({super.key, required this.title, required this.subtitle, required this.user});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  key: const Key('user_dashboard_title'),
                  title,
                  style: theme.textTheme.titleLarge?.copyWith(color: theme.colorScheme.onPrimaryContainer),
                  textAlign: TextAlign.start,
                ),
                Text(
                  key: const Key('user_dashboard_subtitle'),
                  subtitle,
                  style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onPrimaryContainer.withAlpha(80)),
                  textAlign: TextAlign.start,
                ),
              ],
            ),

            DashboardUserIcon(key: const Key('user_dashboard_icon'), firstName: user.firstName, lastName: user.lastName),
          ],
        ),

        SizedBox(height: context.height(7)),
      ],
    );
  }
}
