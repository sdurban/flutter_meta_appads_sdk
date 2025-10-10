import '../pigeon_generated.dart' as pigeon;
import 'fb_log_event_command.dart';
import 'fb_log_purchase_command.dart';
import 'fb_log_standard_event_command.dart';
import 'fb_set_data_processing_options_command.dart';
import 'fb_set_user_data_command.dart';

class ObjectsToPigeonCommunications {
  static pigeon.FBLogEventRequest logEventCommandToPigeon(
      FBLogEventCommand command) {
    return pigeon.FBLogEventRequest(
      eventName: command.eventName,
      eventParameters: command.eventParameters,
    );
  }

  static pigeon.FBLogPurchaseRequest logPurchaseCommandToPigeon(
      FBLogPurchaseCommand command) {
    return pigeon.FBLogPurchaseRequest(
      amount: command.amount,
      currency: command.currency,
      eventParameter: command.eventParameter,
    );
  }

  static pigeon.FBLogStandardEventRequest logStandardEventCommandToPigeon(
      FBLogStandardEventCommand command) {
    return pigeon.FBLogStandardEventRequest(
      eventName: _eventToPigeonEnum(command.event),
      parameters: _eventParametersToPigeon(command.parameters),
    );
  }

  static pigeon.FBSetDataProcessingOptionsRequest setDataProcessingCommandToPigeon(
      FBSetDataProcessingOptionsCommand command) {
    return pigeon.FBSetDataProcessingOptionsRequest(
      modes: command.modes,
      country: command.country,
      state: command.state,
    );
  }

  static pigeon.FBSetUserDataRequest setUserDataCommandToPigeon(
    FBSetUserDataCommand command,
  ) {
    return pigeon.FBSetUserDataRequest(
      type: _userTypeToPigeon(command.type),
      value: command.value,
    );
  }

  static pigeon.FBStandardEvent _eventToPigeonEnum(
    FBStandardEvent event,
  ) {
    // Convertir del enum original al enum de Pigeon
    switch (event) {
      case FBStandardEvent.adClick:
        return pigeon.FBStandardEvent.adClick;
      case FBStandardEvent.adImpression:
        return pigeon.FBStandardEvent.adImpression;
      case FBStandardEvent.completedRegistration:
        return pigeon.FBStandardEvent.completedRegistration;
      case FBStandardEvent.completedTutorial:
        return pigeon.FBStandardEvent.completedTutorial;
      case FBStandardEvent.contact:
        return pigeon.FBStandardEvent.contact;
      case FBStandardEvent.customizeProduct:
        return pigeon.FBStandardEvent.customizeProduct;
      case FBStandardEvent.donate:
        return pigeon.FBStandardEvent.donate;
      case FBStandardEvent.findLocation:
        return pigeon.FBStandardEvent.findLocation;
      case FBStandardEvent.rated:
        return pigeon.FBStandardEvent.rated;
      case FBStandardEvent.schedule:
        return pigeon.FBStandardEvent.schedule;
      case FBStandardEvent.searched:
        return pigeon.FBStandardEvent.searched;
      case FBStandardEvent.startTrial:
        return pigeon.FBStandardEvent.startTrial;
      case FBStandardEvent.submitApplication:
        return pigeon.FBStandardEvent.submitApplication;
      case FBStandardEvent.subscribe:
        return pigeon.FBStandardEvent.subscribe;
      case FBStandardEvent.viewedContent:
        return pigeon.FBStandardEvent.viewedContent;
      case FBStandardEvent.addedPaymentInfo:
        return pigeon.FBStandardEvent.addedPaymentInfo;
      case FBStandardEvent.addedToCart:
        return pigeon.FBStandardEvent.addedToCart;
      case FBStandardEvent.addedToWishlist:
        return pigeon.FBStandardEvent.addedToWishlist;
      case FBStandardEvent.initiatedCheckout:
        return pigeon.FBStandardEvent.initiatedCheckout;
      case FBStandardEvent.purchased:
        return pigeon.FBStandardEvent.purchased;
      case FBStandardEvent.achievedLevel:
        return pigeon.FBStandardEvent.achievedLevel;
      case FBStandardEvent.unlockedAchievement:
        return pigeon.FBStandardEvent.unlockedAchievement;
      case FBStandardEvent.spentCredits:
        return pigeon.FBStandardEvent.spentCredits;
    }
  }

  static pigeon.FBStandardParameter _standardParametersToPigeon({
    required FBStandardParameter parameter,
  }) {
    // Convertir del enum original al enum de Pigeon
    switch (parameter) {
      case FBStandardParameter.parameterNameContent:
        return pigeon.FBStandardParameter.parameterNameContent;
      case FBStandardParameter.parameterNameContentID:
        return pigeon.FBStandardParameter.parameterNameContentID;
      case FBStandardParameter.parameterNameContentType:
        return pigeon.FBStandardParameter.parameterNameContentType;
      case FBStandardParameter.parameterNameCurrency:
        return pigeon.FBStandardParameter.parameterNameCurrency;
      case FBStandardParameter.parameterNameDescription:
        return pigeon.FBStandardParameter.parameterNameDescription;
      case FBStandardParameter.parameterNameLevel:
        return pigeon.FBStandardParameter.parameterNameLevel;
      case FBStandardParameter.parameterNameMaxRatingValue:
        return pigeon.FBStandardParameter.parameterNameMaxRatingValue;
      case FBStandardParameter.parameterNameNumItems:
        return pigeon.FBStandardParameter.parameterNameNumItems;
      case FBStandardParameter.parameterNamePaymentInfoAvailable:
        return pigeon.FBStandardParameter.parameterNamePaymentInfoAvailable;
      case FBStandardParameter.parameterNameRegistrationMethod:
        return pigeon.FBStandardParameter.parameterNameRegistrationMethod;
      case FBStandardParameter.parameterNameSearchString:
        return pigeon.FBStandardParameter.parameterNameSearchString;
      case FBStandardParameter.parameterNameSuccess:
        return pigeon.FBStandardParameter.parameterNameSuccess;
      case FBStandardParameter.parameterNameAdType:
        return pigeon.FBStandardParameter.parameterNameAdType;
      case FBStandardParameter.parameterNameOrderID:
        return pigeon.FBStandardParameter.parameterNameOrderID;
      case FBStandardParameter.parameterNameEventName:
        return pigeon.FBStandardParameter.parameterNameEventName;
      case FBStandardParameter.parameterNameLogTime:
        return pigeon.FBStandardParameter.parameterNameLogTime;
    }
  }

  static List<pigeon.FBStandardEventParameter> _eventParametersToPigeon(
    Map<FBStandardParameter, String> parameters,
  ) {
    List<pigeon.FBStandardEventParameter> pigeonParameters = [];

    parameters.forEach(
      (key, value) => pigeonParameters.add(
        pigeon.FBStandardEventParameter(
          parameterName: _standardParametersToPigeon(parameter: key),
          value: value,
        ),
      ),
    );

    return pigeonParameters;
  }

  static pigeon.FBUserDataType _userTypeToPigeon(FBUserDataType type) {
    // Convertir del enum original al enum de Pigeon
    switch (type) {
      case FBUserDataType.email:
        return pigeon.FBUserDataType.email;
      case FBUserDataType.firstName:
        return pigeon.FBUserDataType.firstName;
      case FBUserDataType.lastName:
        return pigeon.FBUserDataType.lastName;
      case FBUserDataType.phone:
        return pigeon.FBUserDataType.phone;
      case FBUserDataType.dateOfBirth:
        return pigeon.FBUserDataType.dateOfBirth;
      case FBUserDataType.gender:
        return pigeon.FBUserDataType.gender;
      case FBUserDataType.city:
        return pigeon.FBUserDataType.city;
      case FBUserDataType.state:
        return pigeon.FBUserDataType.state;
      case FBUserDataType.zip:
        return pigeon.FBUserDataType.zip;
      case FBUserDataType.country:
        return pigeon.FBUserDataType.country;
      case FBUserDataType.externalId:
        return pigeon.FBUserDataType.externalId;
    }
  }
}
