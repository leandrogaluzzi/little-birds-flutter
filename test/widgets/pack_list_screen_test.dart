import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:little_birds/screens/pack_list_screen.dart';

void main() {
  /*
  testWidgets('', (WidgetTester tester) async {});
  */

  testWidgets('Pack List Screen should have a top bar with a title',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: PackListScreen()));
    expect(find.text('Packs'), findsOneWidget);
    expect(find.byType(AppBar), findsOneWidget);
  });
}
