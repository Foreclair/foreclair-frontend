import 'package:flutter/material.dart';
import 'package:foreclair/src/data/dao/user_dao.dart';
import 'package:foreclair/src/data/services/http/api_service.dart';
import 'package:foreclair/src/ui/components/navbar/navbar.dart';
import 'package:foreclair/src/ui/pages/dashboard/users/user_dashboard_page.dart';
import 'package:foreclair/src/ui/pages/meteo/weather_page.dart';
import 'package:foreclair/src/ui/views/errors/fetching_error_view.dart';
import 'package:provider/provider.dart';

import '../../../data/providers/navigation_provider.dart';

class LayoutView extends StatefulWidget {
  const LayoutView({super.key});

  @override
  State<LayoutView> createState() => _LayoutViewState();
}

class _LayoutViewState extends State<LayoutView> {
  ApiService apiService = ApiService.instance;

  final pages = const [
    Center(child: UserDashboardPage()),
    Center(child: Text("Page 2")),
    Center(child: WeatherPage()),
    Center(child: Text("Page 4")),
    Center(child: Text("Page 5")),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (UserDao.instance.currentUser == null) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const FetchingErrorView()));
      }
    });
  }

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
