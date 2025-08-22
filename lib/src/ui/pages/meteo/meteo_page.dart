import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foreclair/src/data/dao/user_dao.dart';
import 'package:foreclair/utils/units/size_utils.dart';

import '../../components/navbar/header_layout.dart';
import '../dashboard/users/components/dashboard_layout.dart';

class MeteoPage extends StatefulWidget {
  const MeteoPage({super.key});

  @override
  State<MeteoPage> createState() => _MeteoPageState();
}

class _MeteoPageState extends State<MeteoPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CupertinoPageScaffold(
      backgroundColor: theme.colorScheme.surface,
      child: DashboardLayout(
        height: context.height(15),
        children: [
          HeaderLayout(
            key: const Key('meteo_header'),
            title: 'Poste des Rochelets',
            subtitle: 'Météo',
            user: UserDao.instance.currentUser,
          ),
        ],
      ),
    );
  }
}
