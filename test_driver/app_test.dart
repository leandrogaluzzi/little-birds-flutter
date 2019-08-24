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

    test('loading', () async {
      var key = find.byValueKey('loading');
      expect(await driver.getText(key), 'Loading cards ...');
      await takeScreenshot(driver, 'snapshots/loading.png');
    });

    test('home', () async {
      var key = find.byValueKey('home');
      expect(await driver.getText(key), 'Little Birds');
      await takeScreenshot(driver, 'snapshots/home.png');
    });
  });
}

takeScreenshot(FlutterDriver driver, String path) async {
  final List<int> pixels = await driver.screenshot();
  final File file = new File(path);
  await file.writeAsBytes(pixels);
  print(path);
}
