import 'package:flutter_meta_appads_sdk/flutter_meta_appads_sdk_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('initWebPixel is a no-op by default', () async {
    await _NoopPlatform().initWebPixel(pixelId: 'pixel-id');
  });
}

class _NoopPlatform extends FlutterMetaAppadsSdkPlatform {}
