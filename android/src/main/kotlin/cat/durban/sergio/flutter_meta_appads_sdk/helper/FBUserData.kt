package cat.durban.sergio.flutter_meta_appads_sdk.helper

import cat.durban.sergio.flutter_meta_appads_sdk.FBUserDataType

object FBUserData {
    var email: String? = null
    var firstName: String? = null
    var lastName: String? = null
    var phone: String? = null
    var birthDate: String? = null
    var gender: String? = null
    var city: String? = null
    var state: String? = null
    var zipCode: String? = null
    var country: String? = null

    var externalId: String? = null

    fun populateFromPigeon(key: FBUserDataType, value: String) {
        when (key) {
            FBUserDataType.EMAIL -> email = value
            FBUserDataType.FIRST_NAME -> firstName = value
            FBUserDataType.LAST_NAME -> lastName = value
            FBUserDataType.PHONE -> phone = value
            FBUserDataType.DATE_OF_BIRTH -> birthDate = value
            FBUserDataType.GENDER -> gender = value
            FBUserDataType.CITY -> city = value
            FBUserDataType.STATE -> state = value
            FBUserDataType.ZIP -> zipCode = value
            FBUserDataType.COUNTRY -> country = value
            FBUserDataType.EXTERNAL_ID -> externalId = value
        }
    }
}
