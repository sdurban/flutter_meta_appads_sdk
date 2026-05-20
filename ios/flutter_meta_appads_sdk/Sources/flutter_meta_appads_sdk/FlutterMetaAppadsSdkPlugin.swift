import FBSDKCoreKit
import Flutter
import UIKit

public class FlutterMetaAppadsSdkPlugin: NSObject, FlutterPlugin, FlutterSceneLifeCycleDelegate, FlutterMetaAppadsSdkHostApi {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let instance = FlutterMetaAppadsSdkPlugin()
        
        FlutterMetaAppadsSdkHostApiSetup.setUp(binaryMessenger: registrar.messenger(), api: instance)
        
        // Register for both AppDelegate and SceneDelegate callbacks so the
        // plugin keeps working on apps that have not yet adopted the
        // UIScene lifecycle as well as those that have.
        registrar.addApplicationDelegate(instance)
        registrar.addSceneDelegate(instance)
    }

    private var startUpApplication: UIApplication?
    private var startUpURL: URL?
    private var startUpSourceApplication: String?
    private var startUpAnnotation: Any?
    private var loggingEnabled: Bool = false
    private var sdkInitialized: Bool = false

    // MARK: - UIApplicationDelegate (legacy, pre-UIScene lifecycle)

    public func application(
        _ application: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey: Any] = [:]
    ) -> Bool {
        let sourceApplication = options[.sourceApplication] as? String
        let annotation = options[.annotation]

        forwardOpenURL(
            application: application,
            url: url,
            sourceApplication: sourceApplication,
            annotation: annotation
        )

        // Don't short-circuit other handlers (e.g. Flutter's deep-link router).
        return false
    }

    public func application(
        _ application: UIApplication,
        continue userActivity: NSUserActivity,
        restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void
    ) -> Bool {
        ApplicationDelegate.shared.application(application, continue: userActivity)

        // Don't short-circuit other handlers (e.g. Flutter's deep-link router).
        return false
    }

    // MARK: - FlutterSceneLifeCycleDelegate (UIScene lifecycle)

    public func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions?
    ) -> Bool {
        if let contexts = connectionOptions?.urlContexts {
            forwardURLContexts(contexts)
        }

        return false
    }

    public func scene(
        _ scene: UIScene,
        openURLContexts URLContexts: Set<UIOpenURLContext>
    ) -> Bool {
        forwardURLContexts(URLContexts)

        return false
    }

    public func scene(_ scene: UIScene, continue userActivity: NSUserActivity) -> Bool {
        ApplicationDelegate.shared.application(UIApplication.shared, continue: userActivity)

        // Don't short-circuit other handlers (e.g. Flutter's deep-link router).
        return false
    }

    private func captureStartUp(url: URL, sourceApplication: String?, annotation: Any?) {
        startUpApplication = UIApplication.shared
        startUpURL = url
        startUpSourceApplication = sourceApplication
        startUpAnnotation = annotation
    }

    private func forwardOpenURL(
        application: UIApplication,
        url: URL,
        sourceApplication: String?,
        annotation: Any?
    ) {
        if sdkInitialized {
            ApplicationDelegate.shared.application(
                application,
                open: url,
                sourceApplication: sourceApplication,
                annotation: annotation as Any
            )
        } else {
            // Defer to initSdk() so the SDK can record the launch URL once it
            // is initialized by Dart code.
            captureStartUp(
                url: url,
                sourceApplication: sourceApplication,
                annotation: annotation
            )
        }
    }

    private func forwardURLContexts(_ contexts: Set<UIOpenURLContext>) {
        guard !contexts.isEmpty else { return }

        let application = UIApplication.shared

        for context in contexts {
            forwardOpenURL(
                application: application,
                url: context.url,
                sourceApplication: context.options.sourceApplication,
                annotation: context.options.annotation
            )
        }
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
           let url = startUpURL {
            ApplicationDelegate.shared.application(
                application,
                open: url,
                sourceApplication: startUpSourceApplication,
                annotation: startUpAnnotation as Any
            )
        } else {
            ApplicationDelegate.shared.initializeSDK()
        }

        sdkInitialized = true
        startUpApplication = nil
        startUpURL = nil
        startUpSourceApplication = nil
        startUpAnnotation = nil

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
