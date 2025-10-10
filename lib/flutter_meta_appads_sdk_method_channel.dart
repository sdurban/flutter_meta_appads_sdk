import 'package:flutter/foundation.dart';
import 'package:flutter_meta_appads_sdk/pigeon_generated.dart';

import 'flutter_meta_appads_sdk_platform_interface.dart';

/// An implementation of [FlutterMetaAppadsSdkPlatform] that uses Pigeon.
class MethodChannelFlutterMetaAppadsSdk extends FlutterMetaAppadsSdkPlatform {
  /// The Pigeon API used to interact with the native platform.
  @visibleForTesting
  final FlutterMetaAppadsSdkHostApi api = FlutterMetaAppadsSdkHostApi();

  @override
  Future<void> initSdk({bool enableLogging = false}) async {
    await api.initSdk(enableLogging);
  }

  @override
  Future<void> setUserData(FBSetUserDataRequest request) async {
    await api.setUserData(request);
  }

  @override
  Future<void> logStandardEvent(
      FBLogStandardEventRequest request) async {
    await api.logStandardEvent(request);
  }

  @override
  Future<void> logPurchase(FBLogPurchaseRequest request) async {
    await api.logPurchase(request);
  }

  @override
  Future<void> logEvents(FBLogEventRequest request) async {
    await api.logEvents(request);
  }

  @override
  Future<FBAnonIdResponse?> getFbAnonId() async {
    return await api.getFbAnonId();
  }

  Future<void> setAdvertiserTrackingEnabled({required bool isEnabled}) async {
    await api.setAdvertiserTrackingEnabled(isEnabled);
  }

  Future<void> setAdvertiserIDCollectionEnabled(
      {required bool isEnabled}) async {
    await api.setAdvertiserIDCollectionEnabled(isEnabled);
  }

  Future<void> setAutoLogAppEventsEnabled({required bool isEnabled}) async {
    await api.setAutoLogAppEventsEnabled(isEnabled);
  }

  Future<void> setDataProcessingOptions(
      FBSetDataProcessingOptionsRequest request) async {
    await api.setDataProcessingOptions(request);
  }
}
