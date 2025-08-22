import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foreclair/src/data/providers/navigation_provider.dart';
import 'package:foreclair/src/ui/views/layout/layout_view.dart';
import 'package:provider/provider.dart';

void main() {
  /**
   * Verification des composants de la vue
   */
  testWidgets('Layout View compose', (WidgetTester tester) async {
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
