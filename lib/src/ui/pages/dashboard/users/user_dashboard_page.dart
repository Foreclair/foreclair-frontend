import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foreclair/src/data/dao/user_dao.dart';
import 'package:foreclair/src/data/models/users/user_model.dart';
import 'package:foreclair/src/ui/pages/dashboard/users/components/dashboard_layout.dart';
import 'package:foreclair/src/ui/pages/dashboard/users/components/dashboard_weather_card.dart';
import 'package:foreclair/src/ui/pages/logbook/main/logbook_page.dart';
import 'package:foreclair/utils/units/size_utils.dart';
import 'package:provider/provider.dart';

import '../../../../data/providers/navigation_provider.dart';
import '../../../components/navbar/header_layout.dart';
import 'components/dashboard_logbook_card.dart';

class UserDashboardPage extends StatefulWidget {
  const UserDashboardPage({super.key});

  @override
  State<UserDashboardPage> createState() => _UserDashboardPageState();
}

class _UserDashboardPageState extends State<UserDashboardPage> {
  @override
  Widget build(BuildContext context) {
    UserModel? user = UserDao.instance.currentUser;
    final theme = Theme.of(context);

    return CupertinoPageScaffold(
      backgroundColor: theme.colorScheme.surface,
      child: DashboardLayout(
        height: context.height(35),
        children: [
          HeaderLayout(
            key: const Key('user_dashboard_header'),
            title: 'Poste: ${user?.station.name}',
            subtitle: 'Dashboard',
            user: user,
          ),

          LogbookCard(
            key: const Key('user_dashboard_logbook_card'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LogBookPage()));
            },
          ),

          WeatherCard(
            key: const Key('user_dashboard_meteo_card'),
            onTap: () {
              context.read<NavigationProvider>().setIndex(2);
            },
          ),
        ],
      ),
    );
  }
}
