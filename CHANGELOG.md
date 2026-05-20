### 2.2.0

* iOS: Adopted Apple's `UIScene` lifecycle ([Flutter migration guide](https://docs.flutter.dev/release/breaking-changes/uiscenedelegate#migration-guide-for-flutter-plugins)).
  * Plugin now conforms to `FlutterSceneLifeCycleDelegate` and is registered via `addSceneDelegate` in addition to `addApplicationDelegate`, so it works on hosts whether or not they have migrated to `UIScene`.
  * Captures launch URL info from `scene(_:willConnectTo:options:)` and forwards `scene(_:openURLContexts:)` to the Meta SDK (replacing the legacy `application(_:open:options:)` path on UIScene-based apps).
  * Forwards Universal Links to the Meta SDK from both `application(_:continue:restorationHandler:)` and `scene(_:continue:)` automatically (no AppDelegate changes required).
* iOS: URL opens that occur **after** `initSdk()` are now forwarded to `FBSDKCoreKit.ApplicationDelegate` immediately (previously only the launch URL was delivered, so attribution-related custom-scheme opens during a running session were dropped). All `UIOpenURLContext` entries delivered in a single `scene(_:openURLContexts:)` call are now processed (previously only the first was used).
* Bumped minimum Flutter constraint to `>=3.38.0` (required for `FlutterSceneLifeCycleDelegate` / `addSceneDelegate`).
* Bumped Meta SDK versions:
  * Android: Facebook SDK 18.1.3 → 18.2.3 (thread-safety fixes in `FetchedAppGateKeepersManager`/`AttributionIdentifiers`, `SecureRandom` replaces `java.util.Random`, deprecated `CookieSyncManager` removed, `Build.VERSION.SDK_INT` guard before AdServices APIs, deep link referrer support). No public API changes.
  * iOS: FBSDKCoreKit 18.0.1 → 18.0.3 (reintroduced fast app switching in 18.0.2, anonymous deferral deeplink support in 18.0.3). No public API changes.

### 2.1.0+1

* Update readme (thanks @ltOgt)

### 2.1.0

* Added Swift Package Manager (SPM) support for iOS as an alternative to CocoaPods
* Maintained full backward compatibility with CocoaPods
* Example project demonstrating SPM integration available in `example_spm/` folder

### 2.0.1

* Fix missing format on different files (fixinig pub points on pub.dev).


### 2.0.0

* **BREAKING CHANGE**: Migrated from protobuf to Pigeon for better type safety and performance
* Removed protobuf dependency and all related files
* Improved communication between Flutter and native platforms
* Better error handling and type safety
* Maintained backward compatibility for public API
* Updated build system to use Pigeon code generation
* Fixed currency handling in logPurchase for Android
* Added eventParameter support in logPurchase for both platforms
* Added full support for externalId (FBUserDataType.externalId) on Android platform for advanced matching and cross-device tracking
* Improved logging and error messages
* Meta SDK versions:
  * Android: Facebook SDK 18.1.3
  * iOS: FBSDKCoreKit 18.0.1

### 1.2.0

* Added `setAutoLogAppEventsEnabled` please refer to [Meta Guidelines](https://developers.facebook.com/docs/app-events/automatic-event-collection-detail/) on this function. (Thanks to @Gramatton)
* Upgrade Facebook SDK to 18.0.1 (Android) and 18.0.0 (iOS). (Thanks to @Gramatton)
* Changed protobuf-java to protobuf-javalite for increased performance. (Thanks to @Gramatton)

### 1.1.3

* Fix dangling methodchannel method on Android (thanks to @davidnunes19)

### 1.1.2

* Fix dangling doc

## 1.1.1

* Changes for pub.dev pub points score

## 1.1.0

* Refactor: Reduce external visibility of exposed Protobuf objects.
* Added documentation to exposed methods and objects
* Fix logging issue (not showing logs via logcat) in android integration.

## 1.0.4

* Added `setDataProcessingOptions`  please refer to [Meta documentation](https://developers.facebook.com/docs/app-events/guides/data-processing-options/) on this function.

## 1.0.3

* Added `setAdvertiserIDCollectionEnabled` please refer to Meta documentation on this function.
* Added `setAdvertiserTrackingEnabled` this is for iOS in older version  >(iOS 17) refer to Meta documentation on this function.
* New parameter `enableLogging` in `initSdk` for enabling/disabling console logging.

## 1.0.2

* Allow less restrictive Dart SDK version (3.4.0).

## 1.0.1

* Some changes for pub.dev score.

## 1.0.0

* First initial version.
* iOS SDK 17.4.0.
* Android SDK 17.0.2.
