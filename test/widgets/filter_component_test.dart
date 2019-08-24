import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:little_birds/widgets/filter_component.dart';

void main() {
  testWidgets('FilterComponent', (WidgetTester tester) async {
    final widget = MediaQuery(
      data: MediaQueryData(),
      child: FilterComponent(),
    );

    await tester.pumpWidget(widget);

    final title = find.text('Filter');
    expect(title, findsOneWidget);
  });
}
