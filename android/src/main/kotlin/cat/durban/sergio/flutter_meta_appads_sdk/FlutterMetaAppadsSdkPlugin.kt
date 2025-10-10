package cat.durban.sergio.flutter_meta_appads_sdk

import cat.durban.sergio.flutter_meta_appads_sdk.helper.CurrencyFinder
import cat.durban.sergio.flutter_meta_appads_sdk.helper.FBUserData
import android.content.Context
import android.os.Bundle
import android.util.Log

import com.facebook.AccessToken
import com.facebook.FacebookSdk
import com.facebook.LoggingBehavior
import com.facebook.Profile
import com.facebook.appevents.AppEventsConstants
import com.facebook.appevents.AppEventsLogger

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import java.util.Currency
import java.util.Optional
import kotlin.jvm.optionals.getOrNull

/** FlutterMetaAppadsSdkPlugin */
class FlutterMetaAppadsSdkPlugin: FlutterPlugin, FlutterMetaAppadsSdkHostApi {
  private lateinit var eventsLogger: AppEventsLogger
  private var userData: FBUserData = FBUserData
  private lateinit var context: Context
  private var loggingEnabled: Boolean = false

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    context = flutterPluginBinding.applicationContext
    eventsLogger = AppEventsLogger.newLogger(flutterPluginBinding.applicationContext)
    
    FlutterMetaAppadsSdkHostApi.setUp(flutterPluginBinding.binaryMessenger, this)
  }

  // MARK: - FlutterMetaAppadsSdkHostApi Implementation
  
  override fun initSdk(enableLogging: Boolean) {
    loggingEnabled = enableLogging
    
    if (loggingEnabled) {
      FacebookSdk.setIsDebugEnabled(true)
      FacebookSdk.addLoggingBehavior(LoggingBehavior.APP_EVENTS)
      FacebookSdk.addLoggingBehavior(LoggingBehavior.DEVELOPER_ERRORS)
    }

    FacebookSdk.setAutoInitEnabled(true)
    FacebookSdk.fullyInitialize()

    if (loggingEnabled) {
      Log.d("FBSDKLog", "Init SDK: ${FacebookSdk.isInitialized()}")
      Log.d("FBSDKLog", "SDK Version: ${FacebookSdk.getSdkVersion()}")
      Log.d("FBSDKLog", "AnonymousID: ${AppEventsLogger.getAnonymousAppDeviceGUID(context)}")
      Log.d("FBSDKLog", "TRACKING ENABLED: ${FacebookSdk.getAdvertiserIDCollectionEnabled()}")
      Log.d("FBSDKLog", "AUTOMATIC EVENT COLLECTION ENABLED: ${FacebookSdk.getAutoLogAppEventsEnabled()}")
    }
  }

  override fun setUserData(request: FBSetUserDataRequest) {
    setUserDataInternal(request)
  }
  
  override fun logStandardEvent(request: FBLogStandardEventRequest) {
    logStandardEventInternal(request)
  }
  
  override fun logPurchase(request: FBLogPurchaseRequest) {
    logPurchaseInternal(request)
  }
  
  override fun logEvents(request: FBLogEventRequest) {
    logEventInternal(request)
  }
  
  override fun getFbAnonId(): FBAnonIdResponse? {
    val anonId = AppEventsLogger.getAnonymousAppDeviceGUID(context).toString()
    return FBAnonIdResponse(fbAnonId = anonId)
  }
  
  override fun setAdvertiserTrackingEnabled(isEnabled: Boolean) {
    // NOTHING TO DO - EXCLUSIVE iOS FUNCTIONALITY
  }
  
  override fun setAdvertiserIDCollectionEnabled(isEnabled: Boolean) {
    FacebookSdk.setAdvertiserIDCollectionEnabled(isEnabled)

    if (loggingEnabled) {
      Log.d("FBSDKLog", "TRACKING ENABLED: ${FacebookSdk.getAdvertiserIDCollectionEnabled()}")
    }
  }
  
  override fun setAutoLogAppEventsEnabled(isEnabled: Boolean) {
    FacebookSdk.setAutoLogAppEventsEnabled(isEnabled)

    if (loggingEnabled) {
      Log.d("FBSDKLog", "AUTOMATIC EVENT COLLECTION ENABLED: ${FacebookSdk.getAutoLogAppEventsEnabled()}")
    }
  }

  override fun setDataProcessingOptions(request: FBSetDataProcessingOptionsRequest) {
    if (request.country != null && request.state != null) {
      FacebookSdk.setDataProcessingOptions(
        request.modes.toTypedArray(),
        request.country.toInt(),
        request.state.toInt(),
      )
    } else {
      FacebookSdk.setDataProcessingOptions(
        request.modes.toTypedArray(),
      )
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
  }

  private fun logEventInternal(request: FBLogEventRequest) {
    val params = Bundle()

    for (key in request.eventParameters.keys) {
      val value = request.eventParameters[key]

      params.putString(key, value)
    }

    eventsLogger.logEvent(request.eventName, params)
  }

  private fun logPurchaseInternal(request: FBLogPurchaseRequest) {
    val params = Bundle()
    
    for (key in request.eventParameter.keys) {
      val value = request.eventParameter[key]
      params.putString(key, value)
    }
    
    val currency = CurrencyFinder.find(request.currency).orElse(null)
    
    if (currency != null) {
      eventsLogger.logPurchase(request.amount.toBigDecimal(), currency, params)
    } else {
      Log.e("FlutterMetaAppAdsSdk", "logPurchaseInternal: Currency inválida: ${request.currency}")
    }
  }

  private fun logStandardEventInternal(request: FBLogStandardEventRequest) {
    val eventName = pigeonEnumToEventName(request.eventName)
    if (eventName != null) {
      val params = Bundle()

      for (elm in request.parameters) {
        val elmKey = pigeonEnumToEventParameter(elm.parameterName)

        if (elmKey != null) {
          params.putString(elmKey, elm.value)
        }
      }

      eventsLogger.logEvent(eventName, params)
    }
  }

  private fun setUserDataInternal(request: FBSetUserDataRequest) {
      userData.populateFromPigeon(request.type, request.value)

      AppEventsLogger.setUserData(
        userData.email,
        userData.firstName,
        userData.lastName,
        userData.phone,
        userData.birthDate,
        userData.gender,
        userData.city,
        userData.state,
        userData.zipCode,
        userData.country,
        userData.externalId
      )
  }
  
  // MARK: - Convert Pigeon enums to SDK Values
  
  private fun pigeonEnumToEventName(eventName: FBStandardEvent): String? {
    return when (eventName) {
      FBStandardEvent.AD_CLICK -> AppEventsConstants.EVENT_NAME_AD_CLICK
      FBStandardEvent.AD_IMPRESSION -> AppEventsConstants.EVENT_NAME_AD_IMPRESSION
      FBStandardEvent.COMPLETED_REGISTRATION -> AppEventsConstants.EVENT_NAME_COMPLETED_REGISTRATION
      FBStandardEvent.COMPLETED_TUTORIAL -> AppEventsConstants.EVENT_NAME_COMPLETED_TUTORIAL
      FBStandardEvent.CONTACT -> AppEventsConstants.EVENT_NAME_CONTACT
      FBStandardEvent.CUSTOMIZE_PRODUCT -> AppEventsConstants.EVENT_NAME_CUSTOMIZE_PRODUCT
      FBStandardEvent.DONATE -> AppEventsConstants.EVENT_NAME_DONATE
      FBStandardEvent.FIND_LOCATION -> AppEventsConstants.EVENT_NAME_FIND_LOCATION
      FBStandardEvent.RATED -> AppEventsConstants.EVENT_NAME_RATED
      FBStandardEvent.SCHEDULE -> AppEventsConstants.EVENT_NAME_SCHEDULE
      FBStandardEvent.SEARCHED -> AppEventsConstants.EVENT_NAME_SEARCHED
      FBStandardEvent.START_TRIAL -> AppEventsConstants.EVENT_NAME_START_TRIAL
      FBStandardEvent.SUBMIT_APPLICATION -> AppEventsConstants.EVENT_NAME_SUBMIT_APPLICATION
      FBStandardEvent.SUBSCRIBE -> AppEventsConstants.EVENT_NAME_SUBSCRIBE
      FBStandardEvent.VIEWED_CONTENT -> AppEventsConstants.EVENT_NAME_VIEWED_CONTENT
      FBStandardEvent.ADDED_PAYMENT_INFO -> AppEventsConstants.EVENT_NAME_ADDED_PAYMENT_INFO
      FBStandardEvent.ADDED_TO_CART -> AppEventsConstants.EVENT_NAME_ADDED_TO_CART
      FBStandardEvent.ADDED_TO_WISHLIST -> AppEventsConstants.EVENT_NAME_ADDED_TO_WISHLIST
      FBStandardEvent.INITIATED_CHECKOUT -> AppEventsConstants.EVENT_NAME_INITIATED_CHECKOUT
      FBStandardEvent.PURCHASED -> AppEventsConstants.EVENT_NAME_PURCHASED
      FBStandardEvent.ACHIEVED_LEVEL -> AppEventsConstants.EVENT_NAME_ACHIEVED_LEVEL
      FBStandardEvent.UNLOCKED_ACHIEVEMENT -> AppEventsConstants.EVENT_NAME_UNLOCKED_ACHIEVEMENT
      FBStandardEvent.SPENT_CREDITS -> AppEventsConstants.EVENT_NAME_SPENT_CREDITS
    }
  }
  
  private fun pigeonEnumToEventParameter(eventParameter: FBStandardParameter): String? {
    return when (eventParameter) {
      FBStandardParameter.PARAMETER_NAME_CONTENT -> AppEventsConstants.EVENT_PARAM_CONTENT
      FBStandardParameter.PARAMETER_NAME_CONTENT_ID -> AppEventsConstants.EVENT_PARAM_CONTENT_ID
      FBStandardParameter.PARAMETER_NAME_CONTENT_TYPE -> AppEventsConstants.EVENT_PARAM_CONTENT_TYPE
      FBStandardParameter.PARAMETER_NAME_CURRENCY -> AppEventsConstants.EVENT_PARAM_CURRENCY
      FBStandardParameter.PARAMETER_NAME_DESCRIPTION -> AppEventsConstants.EVENT_PARAM_DESCRIPTION
      FBStandardParameter.PARAMETER_NAME_LEVEL -> AppEventsConstants.EVENT_PARAM_LEVEL
      FBStandardParameter.PARAMETER_NAME_MAX_RATING_VALUE -> AppEventsConstants.EVENT_PARAM_MAX_RATING_VALUE
      FBStandardParameter.PARAMETER_NAME_NUM_ITEMS -> AppEventsConstants.EVENT_PARAM_NUM_ITEMS
      FBStandardParameter.PARAMETER_NAME_PAYMENT_INFO_AVAILABLE -> AppEventsConstants.EVENT_PARAM_PAYMENT_INFO_AVAILABLE
      FBStandardParameter.PARAMETER_NAME_REGISTRATION_METHOD -> AppEventsConstants.EVENT_PARAM_REGISTRATION_METHOD
      FBStandardParameter.PARAMETER_NAME_SEARCH_STRING -> AppEventsConstants.EVENT_PARAM_SEARCH_STRING
      FBStandardParameter.PARAMETER_NAME_SUCCESS -> AppEventsConstants.EVENT_PARAM_SUCCESS
      FBStandardParameter.PARAMETER_NAME_AD_TYPE -> AppEventsConstants.EVENT_PARAM_AD_TYPE
      FBStandardParameter.PARAMETER_NAME_ORDER_ID -> AppEventsConstants.EVENT_PARAM_ORDER_ID
      FBStandardParameter.PARAMETER_NAME_EVENT_NAME -> "fb_event_name"
      FBStandardParameter.PARAMETER_NAME_LOG_TIME -> "fb_log_time"
    }
  }
}
