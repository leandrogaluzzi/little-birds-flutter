import 'dart:io';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Little Birds app', () {
    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
      new Directory('screenshots').create();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('check flutter driver health', () async {
      Health health = await driver.checkHealth();
      print(health.status);
    });

    test('Open first tyrell deck and scroll to more info button', () async {
      final homeList = find.byValueKey('home_list');
      final deck = find.byValueKey('tyrell');
      final title = find.byValueKey('deck_title');
      final deckList = find.byValueKey('deck_list');
      final moreInfo = find.byValueKey('more_info_button');

      await driver.scrollUntilVisible(
        homeList,
        deck,
        dyScroll: -200.0,
      );

      await driver.tap(deck);

      expect(
        await driver.getText(title),
        'Deck',
      );

      await driver.scrollUntilVisible(
        deckList,
        moreInfo,
        dyScroll: -300.0,
      );
    });
  });
}

takeScreenshot(FlutterDriver driver, String path) async {
  final List<int> pixels = await driver.screenshot();
  final File file = new File(path);
  await file.writeAsBytes(pixels);
  print(path);
}
