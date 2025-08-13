import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foreclair/src/ui/views/authentication/login_view.dart';

void main() {
  /**
   * Verification des composants de la vue
   */
  testWidgets('Login View compose', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginView()));

    // expect(find.text('Se connecter'), findsOneWidget);
    expect(find.byKey(const Key('emailField')), findsOneWidget);
    expect(find.byKey(const Key('passwordField')), findsOneWidget);
    expect(find.byKey(const Key('validateLoginButton')), findsOneWidget);
    expect(find.byKey(const Key('identifyLaterText')), findsOneWidget);
  });
}
