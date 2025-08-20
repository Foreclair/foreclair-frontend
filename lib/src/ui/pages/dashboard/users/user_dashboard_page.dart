import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foreclair/src/ui/pages/dashboard/users/components/dashboard_layout.dart';
import 'package:foreclair/src/ui/pages/dashboard/users/components/dashboard_user_icon.dart';
import 'package:foreclair/src/ui/pages/dashboard/users/components/meteo_card.dart';
import 'package:foreclair/src/ui/pages/logbook/main/logbook_page.dart';
import 'package:foreclair/utils/units/size_utils.dart';

import 'components/logbook_card.dart';

class UserDashboardPage extends StatefulWidget {
  const UserDashboardPage({super.key});

  @override
  State<UserDashboardPage> createState() => _UserDashboardPageState();
}

class _UserDashboardPageState extends State<UserDashboardPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CupertinoPageScaffold(
      backgroundColor: theme.colorScheme.surface,
      child: DashboardLayout(
        height: context.height(35),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                key: const Key('user_dashboard_title'),
                'Poste des Rochelets',
                style: theme.textTheme.titleLarge?.copyWith(color: theme.colorScheme.onPrimaryContainer),
              ),
              DashboardUserIcon(key: const Key('user_dashboard_icon'), firstName: "Paul", lastName: "Salaun"),
            ],
          ),

          SizedBox(height: context.height(7)),

          LogbookCard(
            key: const Key('user_dashboard_logbook_card'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LogBookPage()));
            },
          ),

          MeteoCard(key: const Key('user_dashboard_meteo_card')),
        ],
      ),
    );
  }
}
