# flutter_meta_appads_sdk

This Flutter plugin provides a simple interface to interact with the Meta SDK. It allows you to initialize the SDK, set user data, log standard events, log purchases, and log custom events.

## Platform support

* Android: uses the native Meta SDK.
* iOS: uses FBSDKCoreKit and supports both CocoaPods and Swift Package Manager.
* Web: uses Meta Pixel.

### iOS lifecycle support

Starting with `2.2.0`, the iOS plugin supports Apple's `UIScene` lifecycle. It registers itself as both an application delegate and a scene delegate, automatically forwarding custom URL schemes and Universal Links to the Meta SDK without requiring manual `AppDelegate` or `SceneDelegate` changes.

### Installation
You must first create an app at Facebook developers: https://developers.facebook.com/

Get your *app id* and *client token* from [Meta Developers Panel](https://developers.facebook.com/apps/) for mobile integrations, and your *Pixel ID* for web integrations. The following are the main steps for integration. *Please use these as a reference and always consult the official documentation* for [iOS integration](https://developers.facebook.com/docs/app-events/getting-started-app-events-ios), [Android Integration](https://developers.facebook.com/docs/app-events/getting-started-app-events-android#7--add-app-events), and [Meta Pixel](https://developers.facebook.com/docs/meta-pixel/get-started).

#### iOS install

The iOS plugin works with both CocoaPods and Swift Package Manager. Use `example/` as a CocoaPods reference project and `example_spm/` as a Swift Package Manager reference project.

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

Note that this setting will be overwritten by a UI toggle located under App Events in the App Dashboard or Events Manager (`developers.facebook.com/apps/[your-facebook-app-id]/settings/basic`).
(Labeled "Log in-app events automatically")

This toggle is on by default and has to be manually toggled off as well.

Compare the info box under https://developers.facebook.com/docs/app-events/gdpr-compliance.

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

#### Web install

The web implementation uses Meta Pixel. The recommended setup is to initialize the Pixel from Dart:

```dart
final metaSdk = FlutterMetaAppAdsSdk();

await metaSdk.initWebPixel(
  pixelId: '[PIXEL-ID]',
);
```

By default, `initWebPixel` tracks `PageView`. If your app already includes the Meta Pixel base snippet in `web/index.html`, the plugin can reuse the existing `fbq` instance. In that case, avoid tracking `PageView` twice by disabling the automatic `PageView` in one of the setups.

If you use `setUserData(...)` for advanced matching on web, call it before `initWebPixel(...)` so the matching data can be included when Meta Pixel is initialized.

You can also keep the full Meta Pixel snippet in `web/index.html` if you prefer managing Pixel outside Dart. Replace `[PIXEL-ID]` with your Pixel ID and follow the official [Meta Pixel setup guide](https://developers.facebook.com/docs/meta-pixel/get-started).

### Key features

* Platform support:
  * Full Android support through the native Meta SDK.
  * Full iOS support through FBSDKCoreKit with both CocoaPods and Swift Package Manager.
  * Web support through Meta Pixel.
* Initialization:
  * `initSdk()` sets up the native mobile SDK.
  * `initWebPixel(...)` sets up Meta Pixel on web.
* User Data: `setUserData(FBSetUserDataCommand)` provides user information for targeted ads.
  * **Supported data types**: email, firstName, lastName, phone, dateOfBirth, gender, city, state, zip, country, and **externalId**
  * **ExternalId support**: Available on iOS, Android, and Web. Use `FBUserDataType.externalId` to set a custom user identifier for advanced matching and cross-device tracking.
* Event Tracking:
  * `logStandardEvent(FBLogStandardEventCommand)`: Tracks standard events (e.g., level up).
  * `logPurchase(FBLogPurchaseCommand)`: Records purchase events with amount, currency, and additional parameters.
  * `logEvents(FBLogEventCommand)`: Logs custom events.
  * On Web, Meta Pixel standard events are sent with `fbq('track', ...)`; mobile-only standard events without a direct Pixel equivalent are sent as custom Pixel events.
* Anonymous ID: `getFbAnonId()` retrieves the Facebook Anonymous ID on mobile SDK integrations. This is not available on Web.
* Tracking permissions:
  * `setAdvertiserTrackingEnabled(bool)`: Enables or disables advertiser tracking on mobile. On Web, it maps to Meta Pixel consent (`grant`/`revoke`).
  * `setAdvertiserIDCollectionEnabled(bool)`: Available on Android and iOS native SDKs. This is a no-op on Web.
  * `setAutoLogAppEventsEnabled(bool)`: Enables or disables automatic mobile SDK events like app installs, in-app purchases and app launches. On Web, it only controls the automatic `PageView` sent by `initWebPixel(...)`.
  * `setDataProcessingOptions(FBSetDataProcessingOptionsCommand)`: Configures data processing options on Android, iOS, and Web. Refer to [Meta Documentation](https://developers.facebook.com/docs/app-events/guides/data-processing-options)

### SDK Versions

* **Android**: Facebook SDK 18.2.3
* **iOS**: FBSDKCoreKit 18.0.3
* **Web**: Meta Pixel JavaScript (`fbevents.js`)

### iOS UIScene lifecycle

Starting with `2.2.0`, the iOS plugin adopts Apple's `UIScene` lifecycle and registers itself as both an application delegate and a scene delegate. No `AppDelegate` or `SceneDelegate` changes are required on your side: the plugin auto-forwards URL openings (custom URL schemes) and Universal Links (`NSUserActivity`) to the Meta SDK on both the legacy `UIApplicationDelegate` path and the new `UISceneDelegate` path.

This requires Flutter `>=3.38.0`. See the [Flutter UISceneDelegate adoption guide](https://docs.flutter.dev/release/breaking-changes/uiscenedelegate) for context.

### About Meta SDK

Follow the official Meta SDK guide for correct integration: [Meta App Ads URL](https://developers.facebook.com/docs/app-ads/) . Please [report an issue](https://github.com/sdurban/flutter_meta_appads_sdk/issues) if you find anything is not working according to official documentation.
