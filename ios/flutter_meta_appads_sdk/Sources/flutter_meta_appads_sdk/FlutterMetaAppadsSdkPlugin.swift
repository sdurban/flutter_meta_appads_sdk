import FBSDKCoreKit
import Flutter
import UIKit

public class FlutterMetaAppadsSdkPlugin: NSObject, FlutterPlugin, FlutterMetaAppadsSdkHostApi {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let instance = FlutterMetaAppadsSdkPlugin()
        
        FlutterMetaAppadsSdkHostApiSetup.setUp(binaryMessenger: registrar.messenger(), api: instance)
        
        registrar.addApplicationDelegate(instance)
    }

    private var startUpApplication: UIApplication?
    private var startUpURL: URL?
    private var startUpOptions: [UIApplication.OpenURLOptionsKey: Any]?
    private var loggingEnabled: Bool = false

    public func application(
        _ application: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey: Any] = [:]
    ) -> Bool {
        startUpApplication = application
        startUpURL = url
        startUpOptions = options

        return false
    }

    // MARK: - FlutterMetaAppadsSdkHostApi Implementation
    
    func initSdk(enableLogging: Bool) throws {
        loggingEnabled = enableLogging
        initSdk()
    }
    
    func setUserData(request: FBSetUserDataRequest) throws {
        setUserData(request.value, forType: request.type)
    }
    
    func logStandardEvent(request: FBLogStandardEventRequest) throws {
        logEvent(request.eventName, parameters: request.parameters)
    }
    
    func logPurchase(request: FBLogPurchaseRequest) throws {
        logPurchase(request.amount, currency: request.currency, parameters: request.eventParameter)
    }
    
    func logEvents(request: FBLogEventRequest) throws {
        logEvent(request.eventName, parameters: request.eventParameters)
    }
    
    func getFbAnonId() throws -> FBAnonIdResponse? {
        return FBAnonIdResponse(fbAnonId: AppEvents.shared.anonymousID)
    }
    
    func setAdvertiserTrackingEnabled(isEnabled: Bool) throws {
        Settings.shared.isAdvertiserTrackingEnabled = isEnabled
        
        if loggingEnabled {
            print("FBSDKLog: TRACKING ENABLED \(Settings.shared.isAdvertiserTrackingEnabled)")
        }
    }
    
    func setAdvertiserIDCollectionEnabled(isEnabled: Bool) throws {
        Settings.shared.isAdvertiserIDCollectionEnabled = isEnabled
        
        if loggingEnabled {
            print("FBSDKLog: IDFA COLLECTION \(Settings.shared.isAdvertiserIDCollectionEnabled)")
        }
    }
    
    func setAutoLogAppEventsEnabled(isEnabled: Bool) throws {
        Settings.shared.isAutoLogAppEventsEnabled = isEnabled
        
        if loggingEnabled {
            print("FBSDKLog: AUTOMATIC EVENT COLLECTION \(Settings.shared.isAutoLogAppEventsEnabled)")
        }
    }
    
    func setDataProcessingOptions(request: FBSetDataProcessingOptionsRequest) throws {
        if let country = request.country, let state = request.state {
            Settings.shared.setDataProcessingOptions(request.modes, country: Int32(country), state: Int32(state))
        } else {
            Settings.shared.setDataProcessingOptions(request.modes)
        }
    }

    private func initSdk() {
        if loggingEnabled {
            Settings.shared.enableLoggingBehavior(.appEvents)
            Settings.shared.enableLoggingBehavior(.informational)
        }

        if let application = startUpApplication,
           let url = startUpURL,
           let options = startUpOptions {
            ApplicationDelegate.shared.application(
                application,
                open: url,
                sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
                annotation: options[UIApplication.OpenURLOptionsKey.annotation]
            )
        } else {
            ApplicationDelegate.shared.initializeSDK()
        }

        if loggingEnabled {
            print("FBSDKLog: SDK Version: \(Settings.shared.sdkVersion)")
            print("FBSDKLog: AnonymousID: \(AppEvents.shared.anonymousID)")
            print("FBSDKLog: IDFA COLLECTION \(Settings.shared.isAdvertiserIDCollectionEnabled)")
            print("FBSDKLog: TRACKING ENABLED \(Settings.shared.isAdvertiserTrackingEnabled)")
            print("FBSDKLog: AUTOMATIC EVENT COLLECTION \(Settings.shared.isAutoLogAppEventsEnabled)")
        }
    }

    private func logEvent(_ eventName: String, parameters: [String: String]) {
        AppEvents.shared.logEvent(
            AppEvents.Name(eventName),
            parameters: convertCustomParametersToFbParameters(parameters)
        )
    }

    private func logEvent(_ eventName: FBStandardEvent, parameters: [FBStandardEventParameter]) {
        if let appEventName = pigeonEnumToEventName(eventName) {
            AppEvents.shared.logEvent(
                appEventName,
                parameters: convertStandardParametersToFbParameters(parameters)
            )
        }
    }

    private func logPurchase(_ amount: Double, currency: String, parameters: [String: String]) {
        AppEvents.shared.logPurchase(
            amount: amount,
            currency: currency,
            parameters: convertCustomParametersToFbParameters(parameters)
        )
    }

    private func setUserData(_ data: String?, forType: FBUserDataType) {
        if let forType = pigeonEnumToFBSDKAppEventUserDataType(forType) {
            AppEvents.shared.setUserData(data, forType: forType)

            print("FBSDKLog: TRACKING ENABLED \(Settings.shared.isAdvertiserTrackingEnabled)")
        }
    }
}

extension FlutterMetaAppadsSdkPlugin {
    fileprivate func convertCustomParametersToFbParameters(_ parameters: [String: String]) -> [AppEvents.ParameterName: String] {
        var fbParameters: [AppEvents.ParameterName: String] = [:]

        for parameter in parameters {
            fbParameters[AppEvents.ParameterName(rawValue: parameter.key)] = parameter.value
        }

        return fbParameters
    }

    fileprivate func convertStandardParametersToFbParameters(_ parameters: [FBStandardEventParameter]) -> [AppEvents.ParameterName: String] {
        var fbParameters: [AppEvents.ParameterName: String] = [:]

        for parameter in parameters {
            if let parameterName = pigeonEnumToEventParameter(parameter.parameterName) {
                fbParameters[parameterName] = parameter.value
            }
        }

        return fbParameters
    }
}

// MARK: - Convert enums to SDK Values

extension FlutterMetaAppadsSdkPlugin {
    fileprivate func pigeonEnumToEventName(_ eventName: FBStandardEvent) -> AppEvents.Name? {
        switch eventName {
        case .achievedLevel:
            return AppEvents.Name.achievedLevel
        case .adClick:
            return AppEvents.Name.adClick
        case .adImpression:
            return AppEvents.Name.adImpression
        case .completedRegistration:
            return AppEvents.Name.completedRegistration
        case .completedTutorial:
            return AppEvents.Name.completedTutorial
        case .contact:
            return AppEvents.Name.contact
        case .customizeProduct:
            return AppEvents.Name.customizeProduct
        case .donate:
            return AppEvents.Name.donate
        case .findLocation:
            return AppEvents.Name.findLocation
        case .rated:
            return AppEvents.Name.rated
        case .schedule:
            return AppEvents.Name.schedule
        case .searched:
            return AppEvents.Name.searched
        case .startTrial:
            return AppEvents.Name.startTrial
        case .submitApplication:
            return AppEvents.Name.submitApplication
        case .subscribe:
            return AppEvents.Name.subscribe
        case .viewedContent:
            return AppEvents.Name.viewedContent
        case .addedPaymentInfo:
            return AppEvents.Name.addedPaymentInfo
        case .addedToCart:
            return AppEvents.Name.addedToCart
        case .addedToWishlist:
            return AppEvents.Name.addedToWishlist
        case .initiatedCheckout:
            return AppEvents.Name.initiatedCheckout
        case .purchased:
            return AppEvents.Name.purchased
        case .unlockedAchievement:
            return AppEvents.Name.unlockedAchievement
        case .spentCredits:
            return AppEvents.Name.spentCredits
        }
    }

    fileprivate func pigeonEnumToEventParameter(_ eventParameter: FBStandardParameter) -> AppEvents.ParameterName? {
        switch eventParameter {
        case .parameterNameContent:
            return .content
        case .parameterNameContentID:
            return .contentID
        case .parameterNameContentType:
            return .contentType
        case .parameterNameCurrency:
            return .currency
        case .parameterNameDescription:
            return .description
        case .parameterNameLevel:
            return .level
        case .parameterNameMaxRatingValue:
            return .maxRatingValue
        case .parameterNameNumItems:
            return .numItems
        case .parameterNamePaymentInfoAvailable:
            return .paymentInfoAvailable
        case .parameterNameRegistrationMethod:
            return .registrationMethod
        case .parameterNameSearchString:
            return .searchString
        case .parameterNameSuccess:
            return .success
        case .parameterNameAdType:
            return .adType
        case .parameterNameOrderID:
            return .orderID
        case .parameterNameEventName:
            return .eventName
        case .parameterNameLogTime:
            return .logTime
        }
    }

    fileprivate func pigeonEnumToFBSDKAppEventUserDataType(_ type: FBUserDataType) -> FBSDKAppEventUserDataType? {
        switch type {
        case .email:
            return .email
        case .firstName:
            return .firstName
        case .lastName:
            return .lastName
        case .phone:
            return .phone
        case .dateOfBirth:
            return .dateOfBirth
        case .gender:
            return .gender
        case .city:
            return .city
        case .state:
            return .state
        case .zip:
            return .zip
        case .country:
            return .country
        case .externalId:
            return .externalId
        }
    }
}
