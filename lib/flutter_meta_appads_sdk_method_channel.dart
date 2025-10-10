import 'package:flutter/foundation.dart';
import 'package:flutter_meta_appads_sdk/pigeon_generated.dart';

import 'flutter_meta_appads_sdk_platform_interface.dart';

/// An implementation of [FlutterMetaAppadsSdkPlatform] that uses Pigeon.
class MethodChannelFlutterMetaAppadsSdk extends FlutterMetaAppadsSdkPlatform {
  /// The Pigeon API used to interact with the native platform.
  @visibleForTesting
  final FlutterMetaAppadsSdkHostApi _api = FlutterMetaAppadsSdkHostApi();

  @override
  Future<void> initSdk({bool enableLogging = false}) async {
    await _api.initSdk(enableLogging);
  }

  @override
  Future<void> setUserData(FBSetUserDataRequest request) async {
    await _api.setUserData(request);
  }

  @override
  Future<void> logStandardEvent(
      FBLogStandardEventRequest request) async {
    await _api.logStandardEvent(request);
  }

  @override
  Future<void> logPurchase(FBLogPurchaseRequest request) async {
    await _api.logPurchase(request);
  }

  @override
  Future<void> logEvents(FBLogEventRequest request) async {
    await _api.logEvents(request);
  }

  @override
  Future<FBAnonIdResponse?> getFbAnonId() async {
    return await _api.getFbAnonId();
  }

  Future<void> setAdvertiserTrackingEnabled({required bool isEnabled}) async {
    await _api.setAdvertiserTrackingEnabled(isEnabled);
  }

  Future<void> setAdvertiserIDCollectionEnabled(
      {required bool isEnabled}) async {
    await _api.setAdvertiserIDCollectionEnabled(isEnabled);
  }

  Future<void> setAutoLogAppEventsEnabled({required bool isEnabled}) async {
    await _api.setAutoLogAppEventsEnabled(isEnabled);
  }

  Future<void> setDataProcessingOptions(
      FBSetDataProcessingOptionsRequest request) async {
    await _api.setDataProcessingOptions(request);
  }
}
