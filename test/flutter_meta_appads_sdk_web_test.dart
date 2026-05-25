@TestOn('browser')
library;

import 'dart:js_interop';
import 'dart:js_interop_unsafe';

import 'package:flutter_meta_appads_sdk/flutter_meta_appads_sdk.dart';
import 'package:flutter_meta_appads_sdk/flutter_meta_appads_sdk_platform_interface.dart';
import 'package:flutter_meta_appads_sdk/flutter_meta_appads_sdk_web.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late List<List<String?>> fbqCalls;

  setUp(() {
    fbqCalls = <List<String?>>[];
    globalContext['fbq'] = ((
      JSAny? action,
      JSAny? event, [
      JSAny? parameters,
    ]) {
      fbqCalls.add(<String?>[
        _jsStringToDart(action),
        _jsStringToDart(event),
      ]);
    }).toJS;

    FlutterMetaAppadsSdkPlatform.instance = FlutterMetaAppadsSdkWeb();
  });

  tearDown(() {
    globalContext.delete('fbq'.toJS);
  });

  test('initWebPixel initializes Meta Pixel and tracks PageView', () async {
    final sdk = FlutterMetaAppAdsSdk();

    await sdk.setUserData(
      FBSetUserDataCommand(
        type: FBUserDataType.email,
        value: 'user@example.com',
      ),
    );
    await sdk.initWebPixel(pixelId: 'pixel-id');

    expect(fbqCalls, <List<String?>>[
      <String?>['init', 'pixel-id'],
      <String?>['track', 'PageView'],
    ]);
  });

  test('logPurchase tracks the Pixel Purchase standard event', () async {
    final sdk = FlutterMetaAppAdsSdk();

    await sdk.logPurchase(
      FBLogPurchaseCommand(
        amount: 12.34,
        currency: 'USD',
        eventParameter: <String, String>{'order_id': 'order-1'},
      ),
    );

    expect(fbqCalls, <List<String?>>[
      <String?>['track', 'Purchase'],
    ]);
  });

  test('pending advertiser tracking consent is applied before init', () async {
    final sdk = FlutterMetaAppAdsSdk();

    await sdk.setAdvertiserTrackingEnabled(isEnabled: false);
    await sdk.initWebPixel(
      pixelId: 'pixel-id',
      autoLogPageView: false,
    );

    expect(fbqCalls, <List<String?>>[
      <String?>['consent', 'revoke'],
      <String?>['init', 'pixel-id'],
    ]);
  });
}

String? _jsStringToDart(JSAny? value) {
  if (value == null) {
    return null;
  }

  return (value as JSString).toDart;
}
