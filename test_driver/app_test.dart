import 'dart:io';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Little Birds app', () {
    final loading = find.byValueKey('loading');

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
      await takeScreenshot(driver, 'screenshots/loading.png');
      expect(await driver.getText(loading), 'Loading cards ...');
    });
  });
}

takeScreenshot(FlutterDriver driver, String path) async {
  final List<int> pixels = await driver.screenshot();
  final File file = new File(path);
  await file.writeAsBytes(pixels);
  print(path);
}
