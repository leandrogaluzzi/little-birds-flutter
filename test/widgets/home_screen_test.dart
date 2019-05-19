import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:little_birds/screens/home_screen.dart';

void main() {
  /*
  testWidgets('', (WidgetTester tester) async {});
  */

  testWidgets('Home Screen should have a top bar with a title',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: HomeScreen()));
    expect(find.text('Home'), findsOneWidget);
    expect(find.byType(AppBar), findsOneWidget);
  });

  testWidgets('Home Screen should start with an activity indicator active',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: HomeScreen()));
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
