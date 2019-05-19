import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:little_birds/screens/card_list_screen.dart';

void main() {
  /*
  testWidgets('', (WidgetTester tester) async {});
  */

  testWidgets('Card List Screen should have a top bar with a title',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: CardListScreen()));
    expect(find.text('Cards'), findsOneWidget);
    expect(find.byType(AppBar), findsOneWidget);
  });
}
