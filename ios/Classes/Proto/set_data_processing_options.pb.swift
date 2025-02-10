// DO NOT EDIT.
// swift-format-ignore-file
// swiftlint:disable all
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: set_data_processing_options.proto
//
// For information on using the generated types, please see the documentation:
//   https://github.com/apple/swift-protobuf/

import SwiftProtobuf

// If the compiler emits an error on this type, it is because this file
// was generated by a version of the `protoc` Swift plug-in that is
// incompatible with the version of SwiftProtobuf to which you are linking.
// Please ensure that you are building against the same version of the API
// that was used to generate this file.
fileprivate struct _GeneratedWithProtocGenSwiftVersion: SwiftProtobuf.ProtobufAPIVersionCheck {
  struct _2: SwiftProtobuf.ProtobufAPIVersion_2 {}
  typealias Version = _2
}

struct FBSetDataProcessingOptionsRequest: Sendable {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var modes: [String] = []

  var optionalCountry: FBSetDataProcessingOptionsRequest.OneOf_OptionalCountry? = nil

  var country: Int32 {
    get {
      if case .country(let v)? = optionalCountry {return v}
      return 0
    }
    set {optionalCountry = .country(newValue)}
  }

  var optionalState: FBSetDataProcessingOptionsRequest.OneOf_OptionalState? = nil

  var state: Int32 {
    get {
      if case .state(let v)? = optionalState {return v}
      return 0
    }
    set {optionalState = .state(newValue)}
  }

  var unknownFields = SwiftProtobuf.UnknownStorage()

  enum OneOf_OptionalCountry: Equatable, Sendable {
    case country(Int32)

  }

  enum OneOf_OptionalState: Equatable, Sendable {
    case state(Int32)

  }

  init() {}
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

extension FBSetDataProcessingOptionsRequest: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = "FBSetDataProcessingOptionsRequest"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "modes"),
    2: .same(proto: "country"),
    3: .same(proto: "state"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeRepeatedStringField(value: &self.modes) }()
      case 2: try {
        var v: Int32?
        try decoder.decodeSingularInt32Field(value: &v)
        if let v = v {
          if self.optionalCountry != nil {try decoder.handleConflictingOneOf()}
          self.optionalCountry = .country(v)
        }
      }()
      case 3: try {
        var v: Int32?
        try decoder.decodeSingularInt32Field(value: &v)
        if let v = v {
          if self.optionalState != nil {try decoder.handleConflictingOneOf()}
          self.optionalState = .state(v)
        }
      }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    if !self.modes.isEmpty {
      try visitor.visitRepeatedStringField(value: self.modes, fieldNumber: 1)
    }
    try { if case .country(let v)? = self.optionalCountry {
      try visitor.visitSingularInt32Field(value: v, fieldNumber: 2)
    } }()
    try { if case .state(let v)? = self.optionalState {
      try visitor.visitSingularInt32Field(value: v, fieldNumber: 3)
    } }()
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: FBSetDataProcessingOptionsRequest, rhs: FBSetDataProcessingOptionsRequest) -> Bool {
    if lhs.modes != rhs.modes {return false}
    if lhs.optionalCountry != rhs.optionalCountry {return false}
    if lhs.optionalState != rhs.optionalState {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
