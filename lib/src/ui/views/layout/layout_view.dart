import 'package:flutter/material.dart';
import 'package:foreclair/src/ui/components/navbar/navbar.dart';
import 'package:foreclair/src/ui/pages/dashboard/users/user_dashboard_page.dart';

class LayoutView extends StatefulWidget {
  const LayoutView({super.key});

  @override
  State<LayoutView> createState() => _LayoutViewState();
}

class _LayoutViewState extends State<LayoutView> {
  int index = 0;
  final controller = PageController();

  final pages = const [
    Center(child: UserDashboardPage()),
    Center(child: Text("Page 2")),
    Center(child: Text("Page 3")),
    Center(child: Text("Page 4")),
    Center(child: Text("Page 5")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          PageView(
            key: const Key('pageview'),
            controller: controller,
            physics: const BouncingScrollPhysics(),
            onPageChanged: (i) => setState(() => index = i),
            children: pages,
          ),
          Positioned(
            left: 20,
            right: 20,
            bottom: 10,
            child: NavBar(
              key: const Key('navbar'),
              currentIndex: index,
              onTap: (i) {
                setState(() => index = i);
                controller.animateToPage(i, duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
              },
            ),
          ),
        ],
      ),
    );
  }
}
