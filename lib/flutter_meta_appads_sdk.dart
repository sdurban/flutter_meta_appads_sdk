import 'package:flutter_meta_appads_sdk/objects/objects_to_pigeon_communications.dart';

import 'flutter_meta_appads_sdk_platform_interface.dart';
import 'objects/fb_log_event_command.dart';
import 'objects/fb_log_purchase_command.dart';
import 'objects/fb_log_standard_event_command.dart';
import 'objects/fb_set_data_processing_options_command.dart';
import 'objects/fb_set_user_data_command.dart';

export 'objects/fb_log_event_command.dart';
export 'objects/fb_log_purchase_command.dart';
export 'objects/fb_log_standard_event_command.dart';
export 'objects/fb_set_data_processing_options_command.dart';
export "objects/fb_set_user_data_command.dart";

class FlutterMetaAppAdsSdk {
  /// **Initializes the Meta App Ads SDK.**
  ///
  /// This function sets up the Meta App Ads SDK within your Flutter application, enabling
  /// the display of ads.
  ///
  /// **Parameters:**
  ///   * `enableLogging`: An optional boolean flag to control detailed logging. If set to
  ///     `true`, additional log messages will be generated that can be helpful for debugging.
  Future<void> initSdk({
    bool enableLogging = false,
  }) {
    return FlutterMetaAppadsSdkPlatform.instance
        .initSdk(enableLogging: enableLogging);
  }

  /// **Sets user data for advanced matching.**
  ///
  /// This function provides user data to the Meta App Ads SDK, enabling more targeted
  /// ad delivery.
  ///
  /// **Parameters:**
  ///   * `command`: A `FBSetUserDataCommand` object containing the user data to be set.
  ///
  /// **Important Notes:**
  ///   * **Privacy Considerations:** Ensure that you handle user data responsibly and in compliance with applicable privacy regulations. Refer Meta documentation (https://developers.facebook.com/docs/app-events/advanced-matching/)
  Future<void> setUserData(
    FBSetUserDataCommand command,
  ) {
    return FlutterMetaAppadsSdkPlatform.instance.setUserData(
      ObjectsToPigeonCommunications.setUserDataCommandToPigeon(command),
    );
  }

  /// **Logs a standard event to Meta App Ads SDK.**
  ///
  /// This function logs a predefined standard event with optional parameters to the Meta App Ads SDK,
  /// providing valuable insights into user behavior and ad performance.
  ///
  /// **Parameters:**
  ///   * `command`: A `FBLogStandardEventCommand` object containing the standard event to log and
  ///     its associated parameters.
  ///
  /// **Important Notes:**
  ///   * **App Events:** Please refer to Facebook App Events Reference (https://developers.facebook.com/docs/app-events/reference)
  Future<void> logStandardEvent(
    FBLogStandardEventCommand command,
  ) {
    return FlutterMetaAppadsSdkPlatform.instance.logStandardEvent(
      ObjectsToPigeonCommunications.logStandardEventCommandToPigeon(command),
    );
  }

  /// **Logs a purchase event to Meta App Ads SDK.**
  ///
  /// This function logs a purchase event with specific details, such as the purchase amount,
  /// currency, and additional parameters, to the Meta App Ads SDK.
  ///
  /// **Parameters:**
  ///   * `command`: A `FBLogPurchaseCommand` object containing the purchase details
  Future<void> logPurchase(
    FBLogPurchaseCommand command,
  ) {
    return FlutterMetaAppadsSdkPlatform.instance.logPurchase(
      ObjectsToPigeonCommunications.logPurchaseCommandToPigeon(command),
    );
  }

  /// **Logs custom events to Meta App Ads SDK.**
  ///
  /// This function logs custom events with specific names and parameters to the Meta App Ads SDK,
  /// providing flexibility to track custom user interactions and actions within your app.
  ///
  /// **Parameters:**
  ///   * `command`: A `FBLogEventCommand` object containing the custom event name and parameters.
  ///
  /// **Important Notes:**
  ///   * **Custom Event Names:** Choose descriptive event names that accurately reflect the user actions you want to track.
  ///   * **Event Parameters:** Use event parameters to provide additional context about the event, such as numerical values, strings, or boolean values.
  Future<void> logEvents(
    FBLogEventCommand command,
  ) {
    return FlutterMetaAppadsSdkPlatform.instance.logEvents(
      ObjectsToPigeonCommunications.logEventCommandToPigeon(command),
    );
  }

  /// **Retrieves the Facebook Anonymous ID.**
  ///
  /// This function fetches the Facebook Anonymous ID, a unique identifier assigned to
  /// a user's device, which can be used for targeted advertising and analytics.
  ///
  /// **Returns:**
  ///   A `Future` object that resolves to a string containing the Facebook Anonymous ID,
  ///   or `null` if the ID is not available.
  ///
  /// **Important Notes:**
  ///   * **Privacy Considerations:** Handle the Facebook Anonymous ID responsibly and in compliance with privacy regulations.
  Future<String?> getFbAnonId() async {
    return (await FlutterMetaAppadsSdkPlatform.instance.getFbAnonId())
        ?.fbAnonId;
  }

  /// **Sets the advertiser tracking enabled state.**
  ///
  /// This function enables or disables advertiser tracking, controlling whether your app
  /// shares user data with Meta for targeted advertising purposes.
  ///
  /// **Parameters:**
  ///   * `isEnabled`: A boolean flag indicating whether advertiser tracking should be enabled.
  ///
  /// **Important Notes:**
  ///   * **Privacy Considerations:** Be mindful of privacy regulations and user preferences when setting the advertiser tracking state.
  ///   * **Only available in iOS:** Used for reporting ATE State in >iOS17. Refer to Facebook documentation (https://developers.facebook.com/docs/app-events/guides/advertising-tracking-enabled/)
  ///
  Future<void> setAdvertiserTrackingEnabled({
    required bool isEnabled,
  }) async {
    return FlutterMetaAppadsSdkPlatform.instance
        .setAdvertiserTrackingEnabled(isEnabled: isEnabled);
  }

  /// **Sets the advertiser ID collection enabled state.**
  ///
  /// This function enables or disables the collection of advertiser IDs, which are used
  /// to identify devices and track user behavior across different apps and websites.
  ///
  /// **Parameters:**
  ///   * `isEnabled`: A boolean flag indicating whether advertiser ID collection should be enabled.
  ///
  /// **Important Notes:**
  ///   * **Privacy Considerations:** Be mindful of privacy regulations and user preferences when setting the advertiser ID collection state.
  ///   * **Meta Documentation:** Refer to Meta documentation for using this functionality.
  Future<void> setAdvertiserIDCollectionEnabled({
    required bool isEnabled,
  }) async {
    return FlutterMetaAppadsSdkPlatform.instance
        .setAdvertiserIDCollectionEnabled(isEnabled: isEnabled);
  }

  /// **Sets the automatic event collection enabled state.**
  ///
  /// This function enables or disables the automatic event collection.
  /// The SDK by default automatically logs common mobile events from your app like
  /// app installs and app launches. These events are transmitted to Facebook
  /// when an app is opened to provide you insights into your app's User behavior
  /// and ad campaign performance.
  ///
  /// **Parameters:**
  ///   * `isEnabled`: A boolean flag indicating whether automatic event collection should be enabled.
  ///
  /// **Important Notes:**
  ///   * **Privacy Considerations:** Under GDPR and other EU data protection regulations, you are required to obtain end User consent before sending data via Meta SDK.
  ///   * **Meta Documentation:** Refer to Meta documentation for using this functionality here: https://developers.facebook.com/docs/app-events/gdpr-compliance.
  Future<void> setAutoLogAppEventsEnabled({
    required bool isEnabled,
  }) async {
    return FlutterMetaAppadsSdkPlatform.instance
        .setAutoLogAppEventsEnabled(isEnabled: isEnabled);
  }

  /// **Sets data processing options for the Meta App Ads SDK.**
  ///
  /// This function allows you to configure various data processing options, including
  /// data usage and sharing preferences, for the Meta App Ads SDK.
  ///
  /// **Parameters:**
  ///   * `command`: A `FBSetDataProcessingOptionsCommand` object containing the desired data processing options.
  ///
  /// **Important Notes:**
  ///   * **Privacy Considerations:** Ensure that you handle user data responsibly and in compliance with applicable privacy regulations. Please refer to Meta documentation (https://developers.facebook.com/docs/app-events/guides/data-processing-options)
  ///
  Future<void> setDataProcessingOptions(
    FBSetDataProcessingOptionsCommand command,
  ) {
    return FlutterMetaAppadsSdkPlatform.instance.setDataProcessingOptions(
      ObjectsToPigeonCommunications.setDataProcessingCommandToPigeon(command),
    );
  }
}
