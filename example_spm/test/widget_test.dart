import 'package:flutter_meta_appads_sdk/flutter_meta_appads_sdk_platform_interface.dart';
import 'package:flutter_meta_appads_sdk/pigeon_generated.dart';
import 'package:flutter_meta_appads_sdk_example/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late FlutterMetaAppadsSdkPlatform originalPlatform;

  setUp(() {
    originalPlatform = FlutterMetaAppadsSdkPlatform.instance;
    FlutterMetaAppadsSdkPlatform.instance = _TestPlatform();
  });

  tearDown(() {
    FlutterMetaAppadsSdkPlatform.instance = originalPlatform;
  });

  testWidgets('SDK controls remain accessible on a small screen',
      (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Init SDK'), findsOneWidget);
    final lastAction = find.text(
      'setDataProcessingOptions - LDU automatic geolocation',
    );
    await tester.scrollUntilVisible(lastAction, 200);
    expect(lastAction.hitTestable(), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('retrieves and displays the anonymous ID', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('FB ANON ID: Not retrieved AnonId'), findsOneWidget);
    await tester.tap(find.text('Get FB AnonId'));
    await tester.pumpAndSettle();

    expect(find.text('FB ANON ID: test-anonymous-id'), findsOneWidget);
  });
}

class _TestPlatform extends FlutterMetaAppadsSdkPlatform {
  @override
  Future<FBAnonIdResponse?> getFbAnonId() async {
    return FBAnonIdResponse(fbAnonId: 'test-anonymous-id');
  }
}
