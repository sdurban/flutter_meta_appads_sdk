// Generated by the protocol buffer compiler. DO NOT EDIT!
// source: fb_anon_id_message.proto

// Generated files should ignore deprecation warnings
@file:Suppress("DEPRECATION")
package cat.durban.sergio.flutter_meta_appads_sdk.proto;

@kotlin.jvm.JvmName("-initializefBAnonIdResponse")
public inline fun fBAnonIdResponse(block: cat.durban.sergio.flutter_meta_appads_sdk.proto.FBAnonIdResponseKt.Dsl.() -> kotlin.Unit): cat.durban.sergio.flutter_meta_appads_sdk.proto.FbAnonIdMessage.FBAnonIdResponse =
  cat.durban.sergio.flutter_meta_appads_sdk.proto.FBAnonIdResponseKt.Dsl._create(cat.durban.sergio.flutter_meta_appads_sdk.proto.FbAnonIdMessage.FBAnonIdResponse.newBuilder()).apply { block() }._build()
/**
 * Protobuf type `FBAnonIdResponse`
 */
public object FBAnonIdResponseKt {
  @kotlin.OptIn(com.google.protobuf.kotlin.OnlyForUseByGeneratedProtoCode::class)
  @com.google.protobuf.kotlin.ProtoDslMarker
  public class Dsl private constructor(
    private val _builder: cat.durban.sergio.flutter_meta_appads_sdk.proto.FbAnonIdMessage.FBAnonIdResponse.Builder
  ) {
    public companion object {
      @kotlin.jvm.JvmSynthetic
      @kotlin.PublishedApi
      internal fun _create(builder: cat.durban.sergio.flutter_meta_appads_sdk.proto.FbAnonIdMessage.FBAnonIdResponse.Builder): Dsl = Dsl(builder)
    }

    @kotlin.jvm.JvmSynthetic
    @kotlin.PublishedApi
    internal fun _build(): cat.durban.sergio.flutter_meta_appads_sdk.proto.FbAnonIdMessage.FBAnonIdResponse = _builder.build()

    /**
     * `string fbAnonId = 1;`
     */
    public var fbAnonId: kotlin.String
      @JvmName("getFbAnonId")
      get() = _builder.getFbAnonId()
      @JvmName("setFbAnonId")
      set(value) {
        _builder.setFbAnonId(value)
      }
    /**
     * `string fbAnonId = 1;`
     */
    public fun clearFbAnonId() {
      _builder.clearFbAnonId()
    }
  }
}
@kotlin.jvm.JvmSynthetic
public inline fun cat.durban.sergio.flutter_meta_appads_sdk.proto.FbAnonIdMessage.FBAnonIdResponse.copy(block: `cat.durban.sergio.flutter_meta_appads_sdk.proto`.FBAnonIdResponseKt.Dsl.() -> kotlin.Unit): cat.durban.sergio.flutter_meta_appads_sdk.proto.FbAnonIdMessage.FBAnonIdResponse =
  `cat.durban.sergio.flutter_meta_appads_sdk.proto`.FBAnonIdResponseKt.Dsl._create(this.toBuilder()).apply { block() }._build()
