# flutter_meta_appads_sdk

This Flutter plugin provides a simple interface to interact with the Meta SDK. It allows you to initialize the SDK, set user data, log standard events, log purchases, and log custom events.

## Platform support

* Android: API 24+; uses the native Meta SDK.
* iOS: iOS 15.0+; uses FBSDKCoreKit and supports both CocoaPods and Swift Package Manager.
* Web: uses Meta Pixel.

### Flutter compatibility

Version `3.0.0` is validated with **Flutter 3.50.1 / Dart 3.14.0**. The plugin's minimum Flutter requirement remains `>=3.38.0`.

Both example apps use **AGP 9.1.1 / Gradle 9.3.1** with built-in Kotlin to meet Flutter 3.50's Android build requirements. The plugin also retains its legacy Kotlin Gradle Plugin setup for apps using older Flutter releases with AGP < 9.

### iOS lifecycle support

Starting with `2.2.0`, the iOS plugin supports Apple's `UIScene` lifecycle. It registers itself as both an application delegate and a scene delegate, automatically forwarding custom URL schemes and Universal Links to the Meta SDK without requiring manual `AppDelegate` or `SceneDelegate` changes.

### Migrating to 3.0.0

Version `3.0.0` upgrades both native Meta SDKs to `19.0.1`. The Dart API is unchanged. Flutter `>=3.38.0` and Android API 24+ are still required.

* **iOS 15.0 is now required** by Meta SDK 19. Set your app and extension deployment targets to at least `15.0`; for CocoaPods, also set `platform :ios, '15.0'` in `ios/Podfile` and follow the CocoaPods setup below.
* Both CocoaPods and Swift Package Manager require Meta SDK `>=19.0.1, <20.0.0`. Other plugins using Facebook SDK components must allow a compatible version in that range. Apps that still require iOS 13–14 or Meta SDK 18 should stay on plugin `2.4.1`.
* With Meta SDK 19, explicitly disabling automatic app events locally takes precedence over enabling them in Events Manager. Review the separate metadata and product improvement settings shown below; both default to enabled.

See the upstream [iOS release notes](https://github.com/meta/facebook-ios-sdk/blob/v19.0.1/CHANGELOG.md) and [Android release notes](https://github.com/meta/facebook-android-sdk/blob/sdk-version-19.0.1/CHANGELOG.md) for the native SDK changes.

### Installation
You must first create an app at Facebook developers: https://developers.facebook.com/

Get your *app id* and *client token* from [Meta Developers Panel](https://developers.facebook.com/apps/) for mobile integrations, and your *Pixel ID* for web integrations. The following are the main steps for integration. *Please use these as a reference and always consult the official documentation* for [iOS integration](https://developers.facebook.com/docs/app-events/getting-started-app-events-ios), [Android Integration](https://developers.facebook.com/docs/app-events/getting-started-app-events-android#7--add-app-events), and [Meta Pixel](https://developers.facebook.com/docs/meta-pixel/get-started).

#### iOS install

The iOS plugin works with both CocoaPods and Swift Package Manager. Swift Package Manager is recommended for new integrations. Use `example/` as a CocoaPods reference project and `example_spm/` as a Swift Package Manager reference project.

**CocoaPods 19.0.1 availability:** As of November 22, 2026, Meta has released 19.0.1 on GitHub, but CocoaPods trunk still lists 19.0.0. The [CocoaPods read-only plan](https://blog.cocoapods.org/CocoaPods-Specs-Repo/) schedules the end of new trunk publications for December 2, 2026. CocoaPods users can install 19.0.1 directly by adding the following inside the `target 'Runner' do` block in `ios/Podfile`. These official release podspecs download Meta's prebuilt XCFrameworks and verify their checksum without requiring publication to trunk:

```ruby
%w[FBSDKCoreKit FBSDKCoreKit_Basics FBAEMKit].each do |name|
  pod name, :podspec => "https://raw.githubusercontent.com/meta/facebook-ios-sdk/v19.0.1/#{name}.podspec"
end
```

Run `flutter pub get` from your app directory, then `pod update FBSDKCoreKit FBSDKCoreKit_Basics FBAEMKit` from `ios/` (or `pod install` for a fresh installation). Keep these declarations while using 19.0.1 through CocoaPods. Swift Package Manager resolves the GitHub release directly and needs no override.

With Xcode 27+, also apply the `post_install` deployment-target adjustment in [the example Podfile](example/ios/Podfile) if Flutter or another pod still declares a target below iOS 15.0.

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

With Meta SDK 19, setting `FacebookAutoLogAppEventsEnabled` to `false` disables automatic app events even when they are enabled in Events Manager.

3. Decide whether you want to disable advertiser identifier tracking by adding this to your Info.plist. Remember, you can later change this setting using the SDK, but having it disabled by default helps you obtain user consent before sending IDs.
```xml
<key>FacebookAdvertiserIDCollectionEnabled</key>
<false/>
```

4. Meta SDK 19 adds separate settings for additional event metadata (such as screen titles and AppLink URLs) and product improvement information. Both default to enabled and are independent of automatic app event logging. To disable them, add:
```xml
<key>FBSDKAutoLogMetaDataEnabled</key>
<false/>
<key>FBSDKAutoLogProductImprovementEnabled</key>
<false/>
```

#### Android Install

> **Gradle compatibility:** this plugin supports AGP 9+ [built-in Kotlin](https://docs.flutter.dev/release/breaking-changes/migrate-to-built-in-kotlin) (no Kotlin Gradle Plugin required) and remains compatible with apps on AGP < 9 using the legacy Kotlin Gradle Plugin setup. Use build tool versions supported by your Flutter release; the examples use AGP 9.1.1 and Gradle 9.3.1 for Flutter 3.50.

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
With Meta SDK 19, setting `com.facebook.sdk.AutoLogAppEventsEnabled` to `false` disables automatic app events even when they are enabled in Events Manager.

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

7. To disable the separate metadata and product improvement settings introduced in Meta SDK 19, add these entries inside `<application>`. Both settings default to enabled and are independent of automatic app event logging.
```xml
<meta-data android:name="com.facebook.sdk.AutoLogMetaDataEnabled"
           android:value="false"/>
<meta-data android:name="com.facebook.sdk.AutoLogProductImprovementEnabled"
           android:value="false"/>
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

* **Android**: Facebook SDK 19.0.1
* **iOS**: FBSDKCoreKit 19.x (`>= 19.0.1, < 20.0.0`) through CocoaPods or Swift Package Manager
* **Web**: Meta Pixel JavaScript (`fbevents.js`)

### iOS UIScene lifecycle

Starting with `2.2.0`, the iOS plugin adopts Apple's `UIScene` lifecycle and registers itself as both an application delegate and a scene delegate. No `AppDelegate` or `SceneDelegate` changes are required on your side: the plugin auto-forwards URL openings (custom URL schemes) and Universal Links (`NSUserActivity`) to the Meta SDK on both the legacy `UIApplicationDelegate` path and the new `UISceneDelegate` path.

This requires Flutter `>=3.38.0`. See the [Flutter UISceneDelegate adoption guide](https://docs.flutter.dev/release/breaking-changes/uiscenedelegate) for context.

### About Meta SDK

Follow the official Meta SDK guide for correct integration: [Meta App Ads URL](https://developers.facebook.com/docs/app-ads/) . Please [report an issue](https://github.com/sdurban/flutter_meta_appads_sdk/issues) if you find anything is not working according to official documentation.
