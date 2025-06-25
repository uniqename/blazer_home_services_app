// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider_app/views/login.dart';

void main() {
  testWidgets('Provider login screen smoke test', (WidgetTester tester) async {
    // Build the login screen directly
    await tester.pumpWidget(const MaterialApp(home: LoginScreen()));

    // Verify that the login screen loads
    expect(find.text('Provider Login'), findsOneWidget);
    expect(find.text('Provider Email'), findsOneWidget);
  });
}
