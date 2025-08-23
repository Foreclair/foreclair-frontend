import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foreclair/src/data/dao/user_dao.dart';
import 'package:foreclair/src/data/models/sector/sector_model.dart';
import 'package:foreclair/src/data/models/station/station_model.dart';
import 'package:foreclair/src/data/models/users/user_model.dart';
import 'package:foreclair/src/data/providers/navigation_provider.dart';
import 'package:foreclair/src/ui/views/layout/layout_view.dart';
import 'package:provider/provider.dart';

void main() {
  /**
   * Verification des composants de la vue
   */
  testWidgets('Layout View compose', (WidgetTester tester) async {
    UserDao.instance.currentUser = UserModel(
      id: "0",
      firstName: "test",
      lastName: "user",
      username: "Test",
      role: "ADMIN",
      sector: Sector(id: "1", location: 12, name: "testSector", stations: []),
      station: Station(id: "2", location: 12.1, name: "testStation"),
    );

    await tester.pumpWidget(
      MultiProvider(
        providers: [ChangeNotifierProvider<NavigationProvider>(create: (_) => NavigationProvider())],
        child: const MaterialApp(home: LayoutView()),
      ),
    );

    expect(find.byKey(const Key('pageview')), findsOneWidget);
    expect(find.byKey(const Key('navbar')), findsOneWidget);
  });
}
