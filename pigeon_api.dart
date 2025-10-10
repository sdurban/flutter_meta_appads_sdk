import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/pigeon_generated.dart',
  kotlinOut: 'android/src/main/kotlin/cat/durban/sergio/flutter_meta_appads_sdk/PigeonGenerated.kt',
  kotlinOptions: KotlinOptions(
    package: 'cat.durban.sergio.flutter_meta_appads_sdk',
  ),
  swiftOut: 'ios/Classes/PigeonGenerated.swift',
))

// Enums para eventos estándar
enum FBStandardEvent {
  adClick,
  adImpression,
  completedRegistration,
  completedTutorial,
  contact,
  customizeProduct,
  donate,
  findLocation,
  rated,
  schedule,
  searched,
  startTrial,
  submitApplication,
  subscribe,
  viewedContent,
  addedPaymentInfo,
  addedToCart,
  addedToWishlist,
  initiatedCheckout,
  purchased,
  achievedLevel,
  unlockedAchievement,
  spentCredits,
}

// Enums para parámetros estándar
enum FBStandardParameter {
  parameterNameContent,
  parameterNameContentID,
  parameterNameContentType,
  parameterNameCurrency,
  parameterNameDescription,
  parameterNameLevel,
  parameterNameMaxRatingValue,
  parameterNameNumItems,
  parameterNamePaymentInfoAvailable,
  parameterNameRegistrationMethod,
  parameterNameSearchString,
  parameterNameSuccess,
  parameterNameAdType,
  parameterNameOrderID,
  parameterNameEventName,
  parameterNameLogTime,
}

// Enums para tipos de datos de usuario
enum FBUserDataType {
  email,
  firstName,
  lastName,
  phone,
  dateOfBirth,
  gender,
  city,
  state,
  zip,
  country,
  externalId,
}

// Clases de datos para eventos
class FBLogEventRequest {
  const FBLogEventRequest({
    required this.eventName,
    required this.eventParameters,
  });

  final String eventName;
  final Map<String, String> eventParameters;
}

class FBLogPurchaseRequest {
  const FBLogPurchaseRequest({
    required this.amount,
    required this.currency,
    required this.eventParameter,
  });

  final double amount;
  final String currency;
  final Map<String, String> eventParameter;
}

class FBStandardEventParameter {
  const FBStandardEventParameter({
    required this.parameterName,
    required this.value,
  });

  final FBStandardParameter parameterName;
  final String value;
}

class FBLogStandardEventRequest {
  const FBLogStandardEventRequest({
    required this.eventName,
    required this.parameters,
  });

  final FBStandardEvent eventName;
  final List<FBStandardEventParameter> parameters;
}

class FBSetUserDataRequest {
  const FBSetUserDataRequest({
    required this.type,
    required this.value,
  });

  final FBUserDataType type;
  final String value;
}

class FBSetDataProcessingOptionsRequest {
  const FBSetDataProcessingOptionsRequest({
    required this.modes,
    this.country,
    this.state,
  });

  final List<String> modes;
  final int? country;
  final int? state;
}

class FBAnonIdResponse {
  const FBAnonIdResponse({
    required this.fbAnonId,
  });

  final String fbAnonId;
}

// API Host - métodos que se implementan en la plataforma nativa
@HostApi()
abstract class FlutterMetaAppadsSdkHostApi {
  void initSdk(bool enableLogging);
  
  void setUserData(FBSetUserDataRequest request);
  
  void logStandardEvent(FBLogStandardEventRequest request);
  
  void logPurchase(FBLogPurchaseRequest request);
  
  void logEvents(FBLogEventRequest request);
  
  FBAnonIdResponse? getFbAnonId();
  
  void setAdvertiserTrackingEnabled(bool isEnabled);
  
  void setAdvertiserIDCollectionEnabled(bool isEnabled);
  
  void setAutoLogAppEventsEnabled(bool isEnabled);
  
  void setDataProcessingOptions(FBSetDataProcessingOptionsRequest request);
}
