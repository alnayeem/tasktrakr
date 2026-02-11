import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasktrakr/app.dart';
import 'helpers/hive_test_helper.dart';

void main() {
  setUpAll(() async {
    await HiveTestHelper.setUp();
  });

  tearDownAll(() async {
    await HiveTestHelper.tearDown();
  });

  setUp(() async {
    await HiveTestHelper.clearBoxes();
  });

  testWidgets('App renders correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ProviderScope(child: TaskTrakrApp()));
    await tester.pump();

    // Verify that the language selection screen is shown (initial route)
    expect(find.text('Choose your language'), findsOneWidget);
  });
}
