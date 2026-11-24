import Flutter
import UIKit
import XCTest


@testable import flutter_meta_appads_sdk

// Native unit tests for the Swift portion of this plugin's implementation.
//
// See https://developer.apple.com/documentation/xctest for more information about using XCTest.

class RunnerTests: XCTestCase {

  // Flutter dispatches application lifecycle callbacks through Objective-C
  // selectors, so a Swift signature that drifts from Flutter's protocol
  // silently stops receiving them.
  func testExposesApplicationLifecycleCallbacksToFlutter() {
    let plugin = FlutterMetaAppadsSdkPlugin()

    XCTAssertTrue(plugin.responds(to: NSSelectorFromString("application:openURL:options:")))
    XCTAssertTrue(
      plugin.responds(to: NSSelectorFromString("application:continueUserActivity:restorationHandler:")))
  }

  func testDoesNotConsumeOpenURLBeforeSdkInitialization() {
    let plugin = FlutterMetaAppadsSdkPlugin()
    let url = URL(string: "fb1234567890://authorize")!

    // Other handlers, such as Flutter's deep-link router, must still receive the URL.
    XCTAssertFalse(plugin.application(UIApplication.shared, open: url, options: [:]))
  }

}
