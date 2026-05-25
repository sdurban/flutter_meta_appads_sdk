import 'dart:js_interop';

import 'package:flutter/foundation.dart';
import 'package:flutter_meta_appads_sdk/pigeon_generated.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:web/web.dart' as web;

import 'flutter_meta_appads_sdk_platform_interface.dart';

@JS('fbq')
external void _fbqTwoArgs(String action, String event);

@JS('fbq')
external void _fbqThreeArgs(String action, String event, JSAny parameters);

@JS('fbq')
external void _fbqDataProcessingOptions(String action, JSAny options);

@JS('fbq')
external void _fbqDataProcessingOptionsWithLocation(
  String action,
  JSAny options,
  JSAny country,
  JSAny state,
);

@JS('window.fbq')
external JSFunction? get _fbqFunction;

class FlutterMetaAppadsSdkWeb extends FlutterMetaAppadsSdkPlatform {
  static void registerWith(Registrar registrar) {
    FlutterMetaAppadsSdkPlatform.instance = FlutterMetaAppadsSdkWeb();
  }

  bool _loggingEnabled = false;
  bool _autoLogAppEventsEnabled = true;
  bool? _pendingConsentGranted;
  String? _pixelId;
  _DataProcessingOptions? _pendingDataProcessingOptions;
  final Map<String, Object> _advancedMatching = <String, Object>{};

  @override
  Future<void> initSdk({bool enableLogging = false}) async {
    _loggingEnabled = enableLogging;
  }

  @override
  Future<void> initWebPixel({
    required String pixelId,
    String locale = 'en_US',
    bool autoLogPageView = true,
  }) async {
    _pixelId = pixelId;
    _ensureFbqScript(locale);
    _applyPendingConsent();
    _applyPendingDataProcessingOptions();

    if (_advancedMatching.isEmpty) {
      _callFbq('init', pixelId);
    } else {
      _callFbq('init', pixelId, _advancedMatching);
    }

    if (autoLogPageView && _autoLogAppEventsEnabled) {
      _callFbq('track', 'PageView');
    }
  }

  @override
  Future<void> logEvents(FBLogEventRequest request) async {
    _callFbq(
      'trackCustom',
      request.eventName,
      Map<String, Object>.from(request.eventParameters),
    );
  }

  @override
  Future<void> logPurchase(FBLogPurchaseRequest request) async {
    _callFbq(
      'track',
      'Purchase',
      <String, Object>{
        ...request.eventParameter,
        'value': request.amount,
        'currency': request.currency,
      },
    );
  }

  @override
  Future<void> logStandardEvent(FBLogStandardEventRequest request) async {
    final event = _webEventFor(request.eventName);
    final parameters = <String, Object>{};

    for (final parameter in request.parameters) {
      parameters[_webParameterFor(parameter.parameterName)] = parameter.value;
    }

    _callFbq(
      event.isStandard ? 'track' : 'trackCustom',
      event.name,
      parameters,
    );
  }

  @override
  Future<void> setUserData(FBSetUserDataRequest request) async {
    _advancedMatching[_advancedMatchingKeyFor(request.type)] = request.value;

    if (_pixelId != null) {
      _logDebug(
        'Advanced matching data updated. Call initWebPixel again only if you '
        'need Meta Pixel to re-read the matching data in the current session.',
      );
    }
  }

  @override
  Future<FBAnonIdResponse?> getFbAnonId() async {
    return null;
  }

  @override
  Future<void> setAdvertiserTrackingEnabled({required bool isEnabled}) async {
    _pendingConsentGranted = isEnabled;
    _applyPendingConsent();
  }

  @override
  Future<void> setAdvertiserIDCollectionEnabled({
    required bool isEnabled,
  }) async {
    _logDebug(
      'setAdvertiserIDCollectionEnabled is a no-op on web. Use your consent '
      'management flow with setAdvertiserTrackingEnabled instead.',
    );
  }

  @override
  Future<void> setAutoLogAppEventsEnabled({required bool isEnabled}) async {
    _autoLogAppEventsEnabled = isEnabled;
  }

  @override
  Future<void> setDataProcessingOptions(
    FBSetDataProcessingOptionsRequest request,
  ) async {
    _pendingDataProcessingOptions = _DataProcessingOptions(
      modes: request.modes,
      country: request.country,
      state: request.state,
    );
    _applyPendingDataProcessingOptions();
  }

  void _callFbq(
    String action,
    String event, [
    Map<String, Object>? parameters,
  ]) {
    if (!_isFbqAvailable) {
      _logDebug(
        'Meta Pixel fbq is not available. Call initWebPixel or load the Pixel '
        'snippet in web/index.html before tracking events.',
      );
      return;
    }

    final filteredParameters = _filterOutEmptyParameters(parameters);

    try {
      if (filteredParameters == null) {
        _fbqTwoArgs(action, event);
      } else {
        _fbqThreeArgs(action, event, _mapToJSObject(filteredParameters));
      }
    } catch (error) {
      _logDebug('Error calling Meta Pixel fbq: $error');
    }
  }

  bool get _isFbqAvailable {
    try {
      return _fbqFunction != null;
    } catch (_) {
      return false;
    }
  }

  void _ensureFbqScript(String locale) {
    if (_isFbqAvailable) {
      return;
    }

    final sanitizedLocale = _sanitizeLocale(locale);
    final script = web.HTMLScriptElement()
      ..type = 'text/javascript'
      ..text = '''
!function(f,b,e,v,n,t,s)
{if(f.fbq)return;n=f.fbq=function(){n.callMethod?
n.callMethod.apply(n,arguments):n.queue.push(arguments)};
if(!f._fbq)f._fbq=n;n.push=n;n.loaded=!0;n.version='2.0';
n.queue=[];t=b.createElement(e);t.async=!0;
t.src=v;s=b.getElementsByTagName(e)[0];
s.parentNode.insertBefore(t,s)}(window, document,'script',
'https://connect.facebook.net/$sanitizedLocale/fbevents.js');
''';

    final parent = web.document.head ?? web.document.body;
    parent?.append(script);
  }

  void _applyPendingConsent() {
    final isEnabled = _pendingConsentGranted;
    if (isEnabled == null || !_isFbqAvailable) {
      return;
    }

    try {
      _fbqTwoArgs('consent', isEnabled ? 'grant' : 'revoke');
      _pendingConsentGranted = null;
    } catch (error) {
      _logDebug('Error setting Meta Pixel consent: $error');
    }
  }

  void _applyPendingDataProcessingOptions() {
    final options = _pendingDataProcessingOptions;
    if (options == null || !_isFbqAvailable) {
      return;
    }

    try {
      final jsModes = options.modes.jsify() as JSAny;

      if (options.country != null && options.state != null) {
        _fbqDataProcessingOptionsWithLocation(
          'dataProcessingOptions',
          jsModes,
          options.country!.toJS,
          options.state!.toJS,
        );
      } else {
        _fbqDataProcessingOptions('dataProcessingOptions', jsModes);
      }

      _pendingDataProcessingOptions = null;
    } catch (error) {
      _logDebug('Error setting Meta Pixel data processing options: $error');
    }
  }

  void _logDebug(String message) {
    if (_loggingEnabled) {
      debugPrint('FlutterMetaAppAdsSdkWeb: $message');
    }
  }
}

JSObject _mapToJSObject(Map<String, Object> map) {
  return map.jsify() as JSObject;
}

Map<String, Object>? _filterOutEmptyParameters(Map<String, Object>? map) {
  if (map == null || map.isEmpty) {
    return null;
  }

  return map;
}

String _sanitizeLocale(String locale) {
  if (RegExp(r'^[A-Za-z]{2}_[A-Za-z]{2}$').hasMatch(locale)) {
    return locale;
  }

  return 'en_US';
}

String _advancedMatchingKeyFor(FBUserDataType type) {
  switch (type) {
    case FBUserDataType.email:
      return 'em';
    case FBUserDataType.firstName:
      return 'fn';
    case FBUserDataType.lastName:
      return 'ln';
    case FBUserDataType.phone:
      return 'ph';
    case FBUserDataType.dateOfBirth:
      return 'db';
    case FBUserDataType.gender:
      return 'ge';
    case FBUserDataType.city:
      return 'ct';
    case FBUserDataType.state:
      return 'st';
    case FBUserDataType.zip:
      return 'zp';
    case FBUserDataType.country:
      return 'country';
    case FBUserDataType.externalId:
      return 'external_id';
  }
}

_WebEvent _webEventFor(FBStandardEvent event) {
  switch (event) {
    case FBStandardEvent.addedPaymentInfo:
      return const _WebEvent('AddPaymentInfo');
    case FBStandardEvent.addedToCart:
      return const _WebEvent('AddToCart');
    case FBStandardEvent.addedToWishlist:
      return const _WebEvent('AddToWishlist');
    case FBStandardEvent.completedRegistration:
      return const _WebEvent('CompleteRegistration');
    case FBStandardEvent.contact:
      return const _WebEvent('Contact');
    case FBStandardEvent.customizeProduct:
      return const _WebEvent('CustomizeProduct');
    case FBStandardEvent.donate:
      return const _WebEvent('Donate');
    case FBStandardEvent.findLocation:
      return const _WebEvent('FindLocation');
    case FBStandardEvent.initiatedCheckout:
      return const _WebEvent('InitiateCheckout');
    case FBStandardEvent.purchased:
      return const _WebEvent('Purchase');
    case FBStandardEvent.schedule:
      return const _WebEvent('Schedule');
    case FBStandardEvent.searched:
      return const _WebEvent('Search');
    case FBStandardEvent.startTrial:
      return const _WebEvent('StartTrial');
    case FBStandardEvent.submitApplication:
      return const _WebEvent('SubmitApplication');
    case FBStandardEvent.subscribe:
      return const _WebEvent('Subscribe');
    case FBStandardEvent.viewedContent:
      return const _WebEvent('ViewContent');
    case FBStandardEvent.achievedLevel:
      return const _WebEvent('AchievedLevel', isStandard: false);
    case FBStandardEvent.adClick:
      return const _WebEvent('AdClick', isStandard: false);
    case FBStandardEvent.adImpression:
      return const _WebEvent('AdImpression', isStandard: false);
    case FBStandardEvent.completedTutorial:
      return const _WebEvent('CompletedTutorial', isStandard: false);
    case FBStandardEvent.rated:
      return const _WebEvent('Rated', isStandard: false);
    case FBStandardEvent.spentCredits:
      return const _WebEvent('SpentCredits', isStandard: false);
    case FBStandardEvent.unlockedAchievement:
      return const _WebEvent('UnlockedAchievement', isStandard: false);
  }
}

String _webParameterFor(FBStandardParameter parameter) {
  switch (parameter) {
    case FBStandardParameter.parameterNameContent:
      return 'content_name';
    case FBStandardParameter.parameterNameContentID:
      return 'content_ids';
    case FBStandardParameter.parameterNameContentType:
      return 'content_type';
    case FBStandardParameter.parameterNameCurrency:
      return 'currency';
    case FBStandardParameter.parameterNameDescription:
      return 'description';
    case FBStandardParameter.parameterNameLevel:
      return 'level';
    case FBStandardParameter.parameterNameMaxRatingValue:
      return 'max_rating_value';
    case FBStandardParameter.parameterNameNumItems:
      return 'num_items';
    case FBStandardParameter.parameterNamePaymentInfoAvailable:
      return 'payment_info_available';
    case FBStandardParameter.parameterNameRegistrationMethod:
      return 'registration_method';
    case FBStandardParameter.parameterNameSearchString:
      return 'search_string';
    case FBStandardParameter.parameterNameSuccess:
      return 'success';
    case FBStandardParameter.parameterNameAdType:
      return 'ad_type';
    case FBStandardParameter.parameterNameOrderID:
      return 'order_id';
    case FBStandardParameter.parameterNameEventName:
      return 'event_name';
    case FBStandardParameter.parameterNameLogTime:
      return 'log_time';
  }
}

class _WebEvent {
  const _WebEvent(this.name, {this.isStandard = true});

  final String name;
  final bool isStandard;
}

class _DataProcessingOptions {
  const _DataProcessingOptions({
    required this.modes,
    required this.country,
    required this.state,
  });

  final List<String> modes;
  final int? country;
  final int? state;
}
