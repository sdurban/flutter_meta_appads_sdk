# flutter_meta_appads_sdk

This Flutter plugin provides a simple interface to interact with the Meta SDK. It allows you to initialize the SDK, set user data, log standard events, log purchases, and log custom events.

## 🚀 Migrated to Pigeon

This plugin has been migrated from protobuf to [Pigeon](https://pub.dev/packages/pigeon) for better type safety, performance, and maintainability. The public API remains unchanged, ensuring backward compatibility.

### Installation
You must first create an app at Facebook developers: https://developers.facebook.com/

Get your *app id* and *client token* from [Meta Developers Panel](https://developers.facebook.com/apps/).The following are the main steps for integration. *Please use these as a reference and always consult the official documentation* for [iOS integration](https://developers.facebook.com/docs/app-events/getting-started-app-events-ios) and [Android Integration](https://developers.facebook.com/docs/app-events/getting-started-app-events-android#7--add-app-events)

#### iOS install

1. Add this snippet to your Info.plist and replace [APP-ID], [CLIENT-TOKEN], and [APP-NAME] with the appropriate values extracted from the Meta panel.
```xml
<key>CFBundleURLTypes</key>
<array>
  <dict>
  <key>CFBundleURLSchemes</key>
  <array>
    <string>fb[APP-ID]</string>
  </array>
  </dict>
</array>
<key>FacebookAppID</key>
<string>[APP-ID]</string>
<key>FacebookClientToken</key>
<string>[CLIENT-TOKEN]</string>
<key>FacebookDisplayName</key>
<string>[APP-NAME]</string>
```
2. Set the following code to true or false in your Info.plist to enable or disable automatic SDK events, respectively.
```xml
<key>FacebookAutoLogAppEventsEnabled</key>
<false/>
```
3. Decide whether you want to disable advertiser identifier tracking by adding this to your Info.plist. Remember, you can later change this setting using the SDK, but having it disabled by default helps you obtain user consent before sending IDs.
```xml
<key>FacebookAdvertiserIDCollectionEnabled</key>
<false/>
```

#### Android Install

1. Add the following meta-data elements within the application element in your `android/app/src/main/AndroidManifest.xml` file to specify your app ID and client access ID:
```xml
<application android:label="string/app_name">
    ...
    <meta-data android:name="com.facebook.sdk.ApplicationId" android:value="@string/facebook_app_id"/>
    <meta-data android:name="com.facebook.sdk.ClientToken" android:value="@string/facebook_client_token"/>
    ...
</application>
```
2. Add uses-permision INTERNET in `android/app/src/main/AndroidManifest.xml`
```xml
...
    </application>

    <uses-permission android:name="android.permission.INTERNET"/>
...
```
3. Add `strings.xml` to your Android app in `android/app/src/main/res/values/strings.xml` replacing [APP-ID] and [CLIENT-TOKEN] with the appropriate values extracted from the Meta panel.
```xml
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <string name="facebook_app_id">[APP-ID]</string>
    <string name="facebook_client_token">[CLIENT-TOKEN]</string>
</resources>
```
4. Set the following code to true or false in your `android/app/src/main/AndroidManifest.xml` to enable or disable automatic SDK events, respectively.
```xml
<application>
  ...
  <meta-data android:name="com.facebook.sdk.AutoLogAppEventsEnabled"
           android:value="false"/>
  ...
</application>
```
5. Decide if your SDK will start on app startup or via `initSdk()` method adding the following code to your `android/app/src/main/AndroidManifest.xml` (having it disabled by default helps you obtain user consent before sending):
```xml
<application>
  ...
  <meta-data android:name="com.facebook.sdk.AutoInitEnabled"
           android:value="false"/>
  ...
</application>
```
6. Decide whether you want to disable advertiser identifier tracking by adding this to your `android/app/src/main/AndroidManifest.xml`. Remember, you can later change this setting using the SDK, but having it disabled by default helps you obtain user consent before sending IDs.
```xml
<application>
  ...
  <meta-data android:name="com.facebook.sdk.AdvertiserIDCollectionEnabled"
           android:value="false"/>
  ...
</application>
```

### Key features

* Initialization: `initSdk()` sets up the SDK.
* User Data: `setUserData(FBSetUserDataCommand)` provides user information for targeted ads.
  * **Supported data types**: email, firstName, lastName, phone, dateOfBirth, gender, city, state, zip, country, and **externalId**
  * **ExternalId support**: Available on both iOS and Android platforms. Use `FBUserDataType.externalId` to set a custom user identifier for advanced matching and cross-device tracking.
* Event Tracking:
  * `logStandardEvent(FBLogStandardEventCommand)`: Tracks standard events (e.g., level up).
  * `logPurchase(FBLogPurchaseCommand)`: Records purchase events with amount, currency, and additional parameters.
  * `logEvents(FBLogEventCommand)`: Logs custom events.
* Anonymous ID: `getFbAnonId()` retrieves the Facebook Anonymous ID.
* Tracking permissions:
  * `setAdvertiserTrackingEnabled(bool)`: This function enables or disables advertiser tracking, controlling whether your app shares user data with Meta for targeted advertising purposes.
  * `setAdvertiserIDCollectionEnabled(bool)`: _Only for iOS (lower than iOS 17)_ Use with ATT permissions request, set to `True` when user allows and `False` when disallows.
  * `setAutoLogAppEventsEnabled(bool)`: This function enables or disables automatic logging of common mobile events from the app like app installs, in-app purchases and app launches.
  * `setDataProcessingOptions(FBSetDataProcessingOptionsCommand)`: This function allows you to configure various data processing options, including data usage and sharing preferences, for the Meta App Ads SDK. Refer to [Meta Documentation](https://developers.facebook.com/docs/app-events/guides/data-processing-options)

### SDK Versions

* **Android**: Facebook SDK 18.1.3
* **iOS**: FBSDKCoreKit 18.0.1


### About Meta SDK

Follow the official Meta SDK guide for correct integration: [Meta App Ads URL](https://developers.facebook.com/docs/app-ads/) . Please [report an issue](https://github.com/sdurban/flutter_meta_appads_sdk/issues) if you find anything is not working according to official documentation.


