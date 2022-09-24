import 'package:ditonton/presentation/widgets/tvseries_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../dummy_data/tvseries_dummy_objects.dart';

void main() {
  Widget _makeTestableWidget(Widget body) {
    return MaterialApp(
      home: Material(
        child: body,
      ),
    );
  }

  group('tvseries card list', () {
    testWidgets('display data', (WidgetTester tester) async {
      await tester.pumpWidget(_makeTestableWidget(TvseriesCard(testTvseries)));
      final posterFinder = find.byType(ClipRRect);
      final textWidgetFinder = find.byType(Text);
      final progressBarFinder = find.byType(CircularProgressIndicator);
      final textFinder = find.text(testTvseries.name!);
      final inkWellFinder = find.byType(InkWell);
      expect(textFinder, findsOneWidget);
      expect(posterFinder, findsOneWidget);
      expect(textWidgetFinder, findsWidgets);
      expect(progressBarFinder, findsOneWidget);
    });
  });
}
