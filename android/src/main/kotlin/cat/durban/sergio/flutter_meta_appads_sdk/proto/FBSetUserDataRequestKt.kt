// Generated by the protocol buffer compiler. DO NOT EDIT!
// source: set_user_data_message.proto

// Generated files should ignore deprecation warnings
@file:Suppress("DEPRECATION")
package cat.durban.sergio.flutter_meta_appads_sdk.proto;

@kotlin.jvm.JvmName("-initializefBSetUserDataRequest")
public inline fun fBSetUserDataRequest(block: cat.durban.sergio.flutter_meta_appads_sdk.proto.FBSetUserDataRequestKt.Dsl.() -> kotlin.Unit): cat.durban.sergio.flutter_meta_appads_sdk.proto.SetUserDataMessage.FBSetUserDataRequest =
  cat.durban.sergio.flutter_meta_appads_sdk.proto.FBSetUserDataRequestKt.Dsl._create(cat.durban.sergio.flutter_meta_appads_sdk.proto.SetUserDataMessage.FBSetUserDataRequest.newBuilder()).apply { block() }._build()
/**
 * Protobuf type `FBSetUserDataRequest`
 */
public object FBSetUserDataRequestKt {
  @kotlin.OptIn(com.google.protobuf.kotlin.OnlyForUseByGeneratedProtoCode::class)
  @com.google.protobuf.kotlin.ProtoDslMarker
  public class Dsl private constructor(
    private val _builder: cat.durban.sergio.flutter_meta_appads_sdk.proto.SetUserDataMessage.FBSetUserDataRequest.Builder
  ) {
    public companion object {
      @kotlin.jvm.JvmSynthetic
      @kotlin.PublishedApi
      internal fun _create(builder: cat.durban.sergio.flutter_meta_appads_sdk.proto.SetUserDataMessage.FBSetUserDataRequest.Builder): Dsl = Dsl(builder)
    }

    @kotlin.jvm.JvmSynthetic
    @kotlin.PublishedApi
    internal fun _build(): cat.durban.sergio.flutter_meta_appads_sdk.proto.SetUserDataMessage.FBSetUserDataRequest = _builder.build()

    /**
     * `optional .FBUserDataType type = 1;`
     */
    public var type: cat.durban.sergio.flutter_meta_appads_sdk.proto.SetUserDataMessage.FBUserDataType
      @JvmName("getType")
      get() = _builder.getType()
      @JvmName("setType")
      set(value) {
        _builder.setType(value)
      }
    public var typeValue: kotlin.Int
      @JvmName("getTypeValue")
      get() = _builder.getTypeValue()
      @JvmName("setTypeValue")
      set(value) {
        _builder.setTypeValue(value)
      }
    /**
     * `optional .FBUserDataType type = 1;`
     */
    public fun clearType() {
      _builder.clearType()
    }
    /**
     * `optional .FBUserDataType type = 1;`
     * @return Whether the type field is set.
     */
    public fun hasType(): kotlin.Boolean {
      return _builder.hasType()
    }

    /**
     * `string value = 2;`
     */
    public var value: kotlin.String
      @JvmName("getValue")
      get() = _builder.getValue()
      @JvmName("setValue")
      set(value) {
        _builder.setValue(value)
      }
    /**
     * `string value = 2;`
     */
    public fun clearValue() {
      _builder.clearValue()
    }
  }
}
@kotlin.jvm.JvmSynthetic
public inline fun cat.durban.sergio.flutter_meta_appads_sdk.proto.SetUserDataMessage.FBSetUserDataRequest.copy(block: `cat.durban.sergio.flutter_meta_appads_sdk.proto`.FBSetUserDataRequestKt.Dsl.() -> kotlin.Unit): cat.durban.sergio.flutter_meta_appads_sdk.proto.SetUserDataMessage.FBSetUserDataRequest =
  `cat.durban.sergio.flutter_meta_appads_sdk.proto`.FBSetUserDataRequestKt.Dsl._create(this.toBuilder()).apply { block() }._build()
