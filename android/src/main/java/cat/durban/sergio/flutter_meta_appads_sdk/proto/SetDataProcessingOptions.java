// Generated by the protocol buffer compiler.  DO NOT EDIT!
// NO CHECKED-IN PROTOBUF GENCODE
// source: set_data_processing_options.proto
// Protobuf Java Version: 4.29.3

package cat.durban.sergio.flutter_meta_appads_sdk.proto;

public final class SetDataProcessingOptions {
  private SetDataProcessingOptions() {}
  public static void registerAllExtensions(
      com.google.protobuf.ExtensionRegistryLite registry) {
  }
  public interface FBSetDataProcessingOptionsRequestOrBuilder extends
      // @@protoc_insertion_point(interface_extends:FBSetDataProcessingOptionsRequest)
      com.google.protobuf.MessageLiteOrBuilder {

    /**
     * <code>repeated string modes = 1;</code>
     * @return A list containing the modes.
     */
    java.util.List<java.lang.String>
        getModesList();
    /**
     * <code>repeated string modes = 1;</code>
     * @return The count of modes.
     */
    int getModesCount();
    /**
     * <code>repeated string modes = 1;</code>
     * @param index The index of the element to return.
     * @return The modes at the given index.
     */
    java.lang.String getModes(int index);
    /**
     * <code>repeated string modes = 1;</code>
     * @param index The index of the element to return.
     * @return The modes at the given index.
     */
    com.google.protobuf.ByteString
        getModesBytes(int index);

    /**
     * <code>int32 country = 2;</code>
     * @return Whether the country field is set.
     */
    boolean hasCountry();
    /**
     * <code>int32 country = 2;</code>
     * @return The country.
     */
    int getCountry();

    /**
     * <code>int32 state = 3;</code>
     * @return Whether the state field is set.
     */
    boolean hasState();
    /**
     * <code>int32 state = 3;</code>
     * @return The state.
     */
    int getState();

    public cat.durban.sergio.flutter_meta_appads_sdk.proto.SetDataProcessingOptions.FBSetDataProcessingOptionsRequest.OptionalCountryCase getOptionalCountryCase();

    public cat.durban.sergio.flutter_meta_appads_sdk.proto.SetDataProcessingOptions.FBSetDataProcessingOptionsRequest.OptionalStateCase getOptionalStateCase();
  }
  /**
   * Protobuf type {@code FBSetDataProcessingOptionsRequest}
   */
  public  static final class FBSetDataProcessingOptionsRequest extends
      com.google.protobuf.GeneratedMessageLite<
          FBSetDataProcessingOptionsRequest, FBSetDataProcessingOptionsRequest.Builder> implements
      // @@protoc_insertion_point(message_implements:FBSetDataProcessingOptionsRequest)
      FBSetDataProcessingOptionsRequestOrBuilder {
    private FBSetDataProcessingOptionsRequest() {
      modes_ = com.google.protobuf.GeneratedMessageLite.emptyProtobufList();
    }
    private int optionalCountryCase_ = 0;
    private java.lang.Object optionalCountry_;
    public enum OptionalCountryCase {
      COUNTRY(2),
      OPTIONALCOUNTRY_NOT_SET(0);
      private final int value;
      private OptionalCountryCase(int value) {
        this.value = value;
      }
      /**
       * @deprecated Use {@link #forNumber(int)} instead.
       */
      @java.lang.Deprecated
      public static OptionalCountryCase valueOf(int value) {
        return forNumber(value);
      }

      public static OptionalCountryCase forNumber(int value) {
        switch (value) {
          case 2: return COUNTRY;
          case 0: return OPTIONALCOUNTRY_NOT_SET;
          default: return null;
        }
      }
      public int getNumber() {
        return this.value;
      }
    };

    @java.lang.Override
    public OptionalCountryCase
    getOptionalCountryCase() {
      return OptionalCountryCase.forNumber(
          optionalCountryCase_);
    }

    private void clearOptionalCountry() {
      optionalCountryCase_ = 0;
      optionalCountry_ = null;
    }

    private int optionalStateCase_ = 0;
    private java.lang.Object optionalState_;
    public enum OptionalStateCase {
      STATE(3),
      OPTIONALSTATE_NOT_SET(0);
      private final int value;
      private OptionalStateCase(int value) {
        this.value = value;
      }
      /**
       * @deprecated Use {@link #forNumber(int)} instead.
       */
      @java.lang.Deprecated
      public static OptionalStateCase valueOf(int value) {
        return forNumber(value);
      }

      public static OptionalStateCase forNumber(int value) {
        switch (value) {
          case 3: return STATE;
          case 0: return OPTIONALSTATE_NOT_SET;
          default: return null;
        }
      }
      public int getNumber() {
        return this.value;
      }
    };

    @java.lang.Override
    public OptionalStateCase
    getOptionalStateCase() {
      return OptionalStateCase.forNumber(
          optionalStateCase_);
    }

    private void clearOptionalState() {
      optionalStateCase_ = 0;
      optionalState_ = null;
    }

    public static final int MODES_FIELD_NUMBER = 1;
    private com.google.protobuf.Internal.ProtobufList<java.lang.String> modes_;
    /**
     * <code>repeated string modes = 1;</code>
     * @return A list containing the modes.
     */
    @java.lang.Override
    public java.util.List<java.lang.String> getModesList() {
      return modes_;
    }
    /**
     * <code>repeated string modes = 1;</code>
     * @return The count of modes.
     */
    @java.lang.Override
    public int getModesCount() {
      return modes_.size();
    }
    /**
     * <code>repeated string modes = 1;</code>
     * @param index The index of the element to return.
     * @return The modes at the given index.
     */
    @java.lang.Override
    public java.lang.String getModes(int index) {
      return modes_.get(index);
    }
    /**
     * <code>repeated string modes = 1;</code>
     * @param index The index of the value to return.
     * @return The bytes of the modes at the given index.
     */
    @java.lang.Override
    public com.google.protobuf.ByteString
        getModesBytes(int index) {
      return com.google.protobuf.ByteString.copyFromUtf8(
          modes_.get(index));
    }
    private void ensureModesIsMutable() {
      com.google.protobuf.Internal.ProtobufList<java.lang.String> tmp =
          modes_;  if (!tmp.isModifiable()) {
        modes_ =
            com.google.protobuf.GeneratedMessageLite.mutableCopy(tmp);
       }
    }
    /**
     * <code>repeated string modes = 1;</code>
     * @param index The index to set the value at.
     * @param value The modes to set.
     */
    @java.lang.SuppressWarnings("ReturnValueIgnored")
    private void setModes(
        int index, java.lang.String value) {
      value.getClass();  // minimal bytecode null check
      ensureModesIsMutable();
      modes_.set(index, value);
    }
    /**
     * <code>repeated string modes = 1;</code>
     * @param value The modes to add.
     */
    @java.lang.SuppressWarnings("ReturnValueIgnored")
    private void addModes(
        java.lang.String value) {
      value.getClass();  // minimal bytecode null check
      ensureModesIsMutable();
      modes_.add(value);
    }
    /**
     * <code>repeated string modes = 1;</code>
     * @param values The modes to add.
     */
    private void addAllModes(
        java.lang.Iterable<java.lang.String> values) {
      ensureModesIsMutable();
      com.google.protobuf.AbstractMessageLite.addAll(
          values, modes_);
    }
    /**
     * <code>repeated string modes = 1;</code>
     */
    private void clearModes() {
      modes_ = com.google.protobuf.GeneratedMessageLite.emptyProtobufList();
    }
    /**
     * <code>repeated string modes = 1;</code>
     * @param value The bytes of the modes to add.
     */
    private void addModesBytes(
        com.google.protobuf.ByteString value) {
      checkByteStringIsUtf8(value);
      ensureModesIsMutable();
      modes_.add(value.toStringUtf8());
    }

    public static final int COUNTRY_FIELD_NUMBER = 2;
    /**
     * <code>int32 country = 2;</code>
     * @return Whether the country field is set.
     */
    @java.lang.Override
    public boolean hasCountry() {
      return optionalCountryCase_ == 2;
    }
    /**
     * <code>int32 country = 2;</code>
     * @return The country.
     */
    @java.lang.Override
    public int getCountry() {
      if (optionalCountryCase_ == 2) {
        return (java.lang.Integer) optionalCountry_;
      }
      return 0;
    }
    /**
     * <code>int32 country = 2;</code>
     * @param value The country to set.
     */
    private void setCountry(int value) {
      optionalCountryCase_ = 2;
      optionalCountry_ = value;
    }
    /**
     * <code>int32 country = 2;</code>
     */
    private void clearCountry() {
      if (optionalCountryCase_ == 2) {
        optionalCountryCase_ = 0;
        optionalCountry_ = null;
      }
    }

    public static final int STATE_FIELD_NUMBER = 3;
    /**
     * <code>int32 state = 3;</code>
     * @return Whether the state field is set.
     */
    @java.lang.Override
    public boolean hasState() {
      return optionalStateCase_ == 3;
    }
    /**
     * <code>int32 state = 3;</code>
     * @return The state.
     */
    @java.lang.Override
    public int getState() {
      if (optionalStateCase_ == 3) {
        return (java.lang.Integer) optionalState_;
      }
      return 0;
    }
    /**
     * <code>int32 state = 3;</code>
     * @param value The state to set.
     */
    private void setState(int value) {
      optionalStateCase_ = 3;
      optionalState_ = value;
    }
    /**
     * <code>int32 state = 3;</code>
     */
    private void clearState() {
      if (optionalStateCase_ == 3) {
        optionalStateCase_ = 0;
        optionalState_ = null;
      }
    }

    public static cat.durban.sergio.flutter_meta_appads_sdk.proto.SetDataProcessingOptions.FBSetDataProcessingOptionsRequest parseFrom(
        java.nio.ByteBuffer data)
        throws com.google.protobuf.InvalidProtocolBufferException {
      return com.google.protobuf.GeneratedMessageLite.parseFrom(
          DEFAULT_INSTANCE, data);
    }
    public static cat.durban.sergio.flutter_meta_appads_sdk.proto.SetDataProcessingOptions.FBSetDataProcessingOptionsRequest parseFrom(
        java.nio.ByteBuffer data,
        com.google.protobuf.ExtensionRegistryLite extensionRegistry)
        throws com.google.protobuf.InvalidProtocolBufferException {
      return com.google.protobuf.GeneratedMessageLite.parseFrom(
          DEFAULT_INSTANCE, data, extensionRegistry);
    }
    public static cat.durban.sergio.flutter_meta_appads_sdk.proto.SetDataProcessingOptions.FBSetDataProcessingOptionsRequest parseFrom(
        com.google.protobuf.ByteString data)
        throws com.google.protobuf.InvalidProtocolBufferException {
      return com.google.protobuf.GeneratedMessageLite.parseFrom(
          DEFAULT_INSTANCE, data);
    }
    public static cat.durban.sergio.flutter_meta_appads_sdk.proto.SetDataProcessingOptions.FBSetDataProcessingOptionsRequest parseFrom(
        com.google.protobuf.ByteString data,
        com.google.protobuf.ExtensionRegistryLite extensionRegistry)
        throws com.google.protobuf.InvalidProtocolBufferException {
      return com.google.protobuf.GeneratedMessageLite.parseFrom(
          DEFAULT_INSTANCE, data, extensionRegistry);
    }
    public static cat.durban.sergio.flutter_meta_appads_sdk.proto.SetDataProcessingOptions.FBSetDataProcessingOptionsRequest parseFrom(byte[] data)
        throws com.google.protobuf.InvalidProtocolBufferException {
      return com.google.protobuf.GeneratedMessageLite.parseFrom(
          DEFAULT_INSTANCE, data);
    }
    public static cat.durban.sergio.flutter_meta_appads_sdk.proto.SetDataProcessingOptions.FBSetDataProcessingOptionsRequest parseFrom(
        byte[] data,
        com.google.protobuf.ExtensionRegistryLite extensionRegistry)
        throws com.google.protobuf.InvalidProtocolBufferException {
      return com.google.protobuf.GeneratedMessageLite.parseFrom(
          DEFAULT_INSTANCE, data, extensionRegistry);
    }
    public static cat.durban.sergio.flutter_meta_appads_sdk.proto.SetDataProcessingOptions.FBSetDataProcessingOptionsRequest parseFrom(java.io.InputStream input)
        throws java.io.IOException {
      return com.google.protobuf.GeneratedMessageLite.parseFrom(
          DEFAULT_INSTANCE, input);
    }
    public static cat.durban.sergio.flutter_meta_appads_sdk.proto.SetDataProcessingOptions.FBSetDataProcessingOptionsRequest parseFrom(
        java.io.InputStream input,
        com.google.protobuf.ExtensionRegistryLite extensionRegistry)
        throws java.io.IOException {
      return com.google.protobuf.GeneratedMessageLite.parseFrom(
          DEFAULT_INSTANCE, input, extensionRegistry);
    }

    public static cat.durban.sergio.flutter_meta_appads_sdk.proto.SetDataProcessingOptions.FBSetDataProcessingOptionsRequest parseDelimitedFrom(java.io.InputStream input)
        throws java.io.IOException {
      return parseDelimitedFrom(DEFAULT_INSTANCE, input);
    }

    public static cat.durban.sergio.flutter_meta_appads_sdk.proto.SetDataProcessingOptions.FBSetDataProcessingOptionsRequest parseDelimitedFrom(
        java.io.InputStream input,
        com.google.protobuf.ExtensionRegistryLite extensionRegistry)
        throws java.io.IOException {
      return parseDelimitedFrom(DEFAULT_INSTANCE, input, extensionRegistry);
    }
    public static cat.durban.sergio.flutter_meta_appads_sdk.proto.SetDataProcessingOptions.FBSetDataProcessingOptionsRequest parseFrom(
        com.google.protobuf.CodedInputStream input)
        throws java.io.IOException {
      return com.google.protobuf.GeneratedMessageLite.parseFrom(
          DEFAULT_INSTANCE, input);
    }
    public static cat.durban.sergio.flutter_meta_appads_sdk.proto.SetDataProcessingOptions.FBSetDataProcessingOptionsRequest parseFrom(
        com.google.protobuf.CodedInputStream input,
        com.google.protobuf.ExtensionRegistryLite extensionRegistry)
        throws java.io.IOException {
      return com.google.protobuf.GeneratedMessageLite.parseFrom(
          DEFAULT_INSTANCE, input, extensionRegistry);
    }

    public static Builder newBuilder() {
      return (Builder) DEFAULT_INSTANCE.createBuilder();
    }
    public static Builder newBuilder(cat.durban.sergio.flutter_meta_appads_sdk.proto.SetDataProcessingOptions.FBSetDataProcessingOptionsRequest prototype) {
      return DEFAULT_INSTANCE.createBuilder(prototype);
    }

    /**
     * Protobuf type {@code FBSetDataProcessingOptionsRequest}
     */
    public static final class Builder extends
        com.google.protobuf.GeneratedMessageLite.Builder<
          cat.durban.sergio.flutter_meta_appads_sdk.proto.SetDataProcessingOptions.FBSetDataProcessingOptionsRequest, Builder> implements
        // @@protoc_insertion_point(builder_implements:FBSetDataProcessingOptionsRequest)
        cat.durban.sergio.flutter_meta_appads_sdk.proto.SetDataProcessingOptions.FBSetDataProcessingOptionsRequestOrBuilder {
      // Construct using cat.durban.sergio.flutter_meta_appads_sdk.proto.SetDataProcessingOptions.FBSetDataProcessingOptionsRequest.newBuilder()
      private Builder() {
        super(DEFAULT_INSTANCE);
      }

      @java.lang.Override
      public OptionalCountryCase
          getOptionalCountryCase() {
        return instance.getOptionalCountryCase();
      }

      public Builder clearOptionalCountry() {
        copyOnWrite();
        instance.clearOptionalCountry();
        return this;
      }

      @java.lang.Override
      public OptionalStateCase
          getOptionalStateCase() {
        return instance.getOptionalStateCase();
      }

      public Builder clearOptionalState() {
        copyOnWrite();
        instance.clearOptionalState();
        return this;
      }


      /**
       * <code>repeated string modes = 1;</code>
       * @return A list containing the modes.
       */
      @java.lang.Override
      public java.util.List<java.lang.String>
          getModesList() {
        return java.util.Collections.unmodifiableList(
            instance.getModesList());
      }
      /**
       * <code>repeated string modes = 1;</code>
       * @return The count of modes.
       */
      @java.lang.Override
      public int getModesCount() {
        return instance.getModesCount();
      }
      /**
       * <code>repeated string modes = 1;</code>
       * @param index The index of the element to return.
       * @return The modes at the given index.
       */
      @java.lang.Override
      public java.lang.String getModes(int index) {
        return instance.getModes(index);
      }
      /**
       * <code>repeated string modes = 1;</code>
       * @param index The index of the value to return.
       * @return The bytes of the modes at the given index.
       */
      @java.lang.Override
      public com.google.protobuf.ByteString
          getModesBytes(int index) {
        return instance.getModesBytes(index);
      }
      /**
       * <code>repeated string modes = 1;</code>
       * @param index The index to set the value at.
       * @param value The modes to set.
       * @return This builder for chaining.
       */
      public Builder setModes(
          int index, java.lang.String value) {
        copyOnWrite();
        instance.setModes(index, value);
        return this;
      }
      /**
       * <code>repeated string modes = 1;</code>
       * @param value The modes to add.
       * @return This builder for chaining.
       */
      public Builder addModes(
          java.lang.String value) {
        copyOnWrite();
        instance.addModes(value);
        return this;
      }
      /**
       * <code>repeated string modes = 1;</code>
       * @param values The modes to add.
       * @return This builder for chaining.
       */
      public Builder addAllModes(
          java.lang.Iterable<java.lang.String> values) {
        copyOnWrite();
        instance.addAllModes(values);
        return this;
      }
      /**
       * <code>repeated string modes = 1;</code>
       * @return This builder for chaining.
       */
      public Builder clearModes() {
        copyOnWrite();
        instance.clearModes();
        return this;
      }
      /**
       * <code>repeated string modes = 1;</code>
       * @param value The bytes of the modes to add.
       * @return This builder for chaining.
       */
      public Builder addModesBytes(
          com.google.protobuf.ByteString value) {
        copyOnWrite();
        instance.addModesBytes(value);
        return this;
      }

      /**
       * <code>int32 country = 2;</code>
       * @return Whether the country field is set.
       */
      @java.lang.Override
      public boolean hasCountry() {
        return instance.hasCountry();
      }
      /**
       * <code>int32 country = 2;</code>
       * @return The country.
       */
      @java.lang.Override
      public int getCountry() {
        return instance.getCountry();
      }
      /**
       * <code>int32 country = 2;</code>
       * @param value The country to set.
       * @return This builder for chaining.
       */
      public Builder setCountry(int value) {
        copyOnWrite();
        instance.setCountry(value);
        return this;
      }
      /**
       * <code>int32 country = 2;</code>
       * @return This builder for chaining.
       */
      public Builder clearCountry() {
        copyOnWrite();
        instance.clearCountry();
        return this;
      }

      /**
       * <code>int32 state = 3;</code>
       * @return Whether the state field is set.
       */
      @java.lang.Override
      public boolean hasState() {
        return instance.hasState();
      }
      /**
       * <code>int32 state = 3;</code>
       * @return The state.
       */
      @java.lang.Override
      public int getState() {
        return instance.getState();
      }
      /**
       * <code>int32 state = 3;</code>
       * @param value The state to set.
       * @return This builder for chaining.
       */
      public Builder setState(int value) {
        copyOnWrite();
        instance.setState(value);
        return this;
      }
      /**
       * <code>int32 state = 3;</code>
       * @return This builder for chaining.
       */
      public Builder clearState() {
        copyOnWrite();
        instance.clearState();
        return this;
      }

      // @@protoc_insertion_point(builder_scope:FBSetDataProcessingOptionsRequest)
    }
    @java.lang.Override
    @java.lang.SuppressWarnings({"unchecked", "fallthrough"})
    protected final java.lang.Object dynamicMethod(
        com.google.protobuf.GeneratedMessageLite.MethodToInvoke method,
        java.lang.Object arg0, java.lang.Object arg1) {
      switch (method) {
        case NEW_MUTABLE_INSTANCE: {
          return new cat.durban.sergio.flutter_meta_appads_sdk.proto.SetDataProcessingOptions.FBSetDataProcessingOptionsRequest();
        }
        case NEW_BUILDER: {
          return new Builder();
        }
        case BUILD_MESSAGE_INFO: {
            java.lang.Object[] objects = new java.lang.Object[] {
              "optionalCountry_",
              "optionalCountryCase_",
              "optionalState_",
              "optionalStateCase_",
              "modes_",
            };
            java.lang.String info =
                "\u0000\u0003\u0002\u0000\u0001\u0003\u0003\u0000\u0001\u0000\u0001\u021a\u00027\u0000" +
                "\u00037\u0001";
            return newMessageInfo(DEFAULT_INSTANCE, info, objects);
        }
        // fall through
        case GET_DEFAULT_INSTANCE: {
          return DEFAULT_INSTANCE;
        }
        case GET_PARSER: {
          com.google.protobuf.Parser<cat.durban.sergio.flutter_meta_appads_sdk.proto.SetDataProcessingOptions.FBSetDataProcessingOptionsRequest> parser = PARSER;
          if (parser == null) {
            synchronized (cat.durban.sergio.flutter_meta_appads_sdk.proto.SetDataProcessingOptions.FBSetDataProcessingOptionsRequest.class) {
              parser = PARSER;
              if (parser == null) {
                parser =
                    new DefaultInstanceBasedParser<cat.durban.sergio.flutter_meta_appads_sdk.proto.SetDataProcessingOptions.FBSetDataProcessingOptionsRequest>(
                        DEFAULT_INSTANCE);
                PARSER = parser;
              }
            }
          }
          return parser;
      }
      case GET_MEMOIZED_IS_INITIALIZED: {
        return (byte) 1;
      }
      case SET_MEMOIZED_IS_INITIALIZED: {
        return null;
      }
      }
      throw new UnsupportedOperationException();
    }


    // @@protoc_insertion_point(class_scope:FBSetDataProcessingOptionsRequest)
    private static final cat.durban.sergio.flutter_meta_appads_sdk.proto.SetDataProcessingOptions.FBSetDataProcessingOptionsRequest DEFAULT_INSTANCE;
    static {
      FBSetDataProcessingOptionsRequest defaultInstance = new FBSetDataProcessingOptionsRequest();
      // New instances are implicitly immutable so no need to make
      // immutable.
      DEFAULT_INSTANCE = defaultInstance;
      com.google.protobuf.GeneratedMessageLite.registerDefaultInstance(
        FBSetDataProcessingOptionsRequest.class, defaultInstance);
    }

    public static cat.durban.sergio.flutter_meta_appads_sdk.proto.SetDataProcessingOptions.FBSetDataProcessingOptionsRequest getDefaultInstance() {
      return DEFAULT_INSTANCE;
    }

    private static volatile com.google.protobuf.Parser<FBSetDataProcessingOptionsRequest> PARSER;

    public static com.google.protobuf.Parser<FBSetDataProcessingOptionsRequest> parser() {
      return DEFAULT_INSTANCE.getParserForType();
    }
  }


  static {
  }

  // @@protoc_insertion_point(outer_class_scope)
}
