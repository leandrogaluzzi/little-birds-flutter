import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:little_birds/main.dart';
import 'package:little_birds/widgets/tab_bar_widget.dart';
import 'package:little_birds/screens/home_screen.dart';
import 'package:little_birds/screens/pack_list_screen.dart';
import 'package:little_birds/screens/card_list_screen.dart';

void main() {
  /*
  testWidgets('', (WidgetTester tester) async {});
  */
  testWidgets('App should have a tab bar with 3 items',
      (WidgetTester tester) async {
    await tester.pumpWidget(LittleBirdsApp());
    expect(find.byType(TabBarWidget), findsOneWidget);
    expect(find.byType(ImageIcon), findsNWidgets(3));
  });

  testWidgets('App should have a tab home with icon and title',
      (WidgetTester tester) async {
    await tester.pumpWidget(LittleBirdsApp());
    expect(find.text('Home'), findsOneWidget);

    var finder = find.byWidgetPredicate((Widget widget) {
      return widget is ImageIcon &&
          widget.image == AssetImage('assets/icons/home.png');
    });

    expect(finder, findsOneWidget);
  });

  testWidgets('App should have a tab packs with icon and title',
      (WidgetTester tester) async {
    await tester.pumpWidget(LittleBirdsApp());
    expect(find.text('Packs'), findsOneWidget);

    var finder = find.byWidgetPredicate((Widget widget) {
      return widget is ImageIcon &&
          widget.image == AssetImage('assets/icons/packs.png');
    });

    expect(finder, findsOneWidget);
  });

  testWidgets('App should have a tab cards with icon and title',
      (WidgetTester tester) async {
    await tester.pumpWidget(LittleBirdsApp());
    expect(find.text('Cards'), findsOneWidget);

    var finder = find.byWidgetPredicate((Widget widget) {
      return widget is ImageIcon &&
          widget.image == AssetImage('assets/icons/cards.png');
    });

    expect(finder, findsOneWidget);
  });

  testWidgets('Home screen should be present', (WidgetTester tester) async {
    await tester.pumpWidget(LittleBirdsApp());
    expect(find.byType(HomeScreen), findsOneWidget);
  });

  testWidgets('Pack List screen should be present',
      (WidgetTester tester) async {
    await tester.pumpWidget(LittleBirdsApp());

    await tester.tap(find.text('Packs'));
    await tester.pump();

    expect(find.byType(PackListScreen), findsOneWidget);
  });

  testWidgets('Card List screen should be present',
      (WidgetTester tester) async {
    await tester.pumpWidget(LittleBirdsApp());

    await tester.tap(find.text('Cards'));
    await tester.pump();

    expect(find.byType(CardListScreen), findsOneWidget);
  });
}
