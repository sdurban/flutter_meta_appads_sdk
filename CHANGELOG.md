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
