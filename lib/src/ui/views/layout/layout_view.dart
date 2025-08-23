import 'package:flutter/material.dart';
import 'package:foreclair/src/data/services/http/api_service.dart';
import 'package:foreclair/src/ui/components/navbar/navbar.dart';
import 'package:foreclair/src/ui/pages/dashboard/users/user_dashboard_page.dart';
import 'package:foreclair/src/ui/pages/meteo/meteo_page.dart';
import 'package:provider/provider.dart';

import '../../../data/providers/navigation_provider.dart';

class LayoutView extends StatelessWidget {
  const LayoutView({super.key});

  final pages = const [
    Center(child: UserDashboardPage()),
    Center(child: Text("Page 2")),
    Center(child: MeteoPage()),
    Center(child: Text("Page 4")),
    Center(child: Text("Page 5")),
  ];

  @override
  Widget build(BuildContext context) {
    final nav = context.watch<NavigationProvider>();

    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          PageView(
            key: const Key('pageview'),
            controller: nav.controller,
            physics: const BouncingScrollPhysics(),
            onPageChanged: nav.updateIndex,
            children: pages,
          ),
          Positioned(
            left: 20,
            right: 20,
            bottom: 10,
            child: NavBar(key: const Key('navbar'), currentIndex: nav.index, onTap: nav.setIndex),
          ),
        ],
      ),
    );
  }
}
