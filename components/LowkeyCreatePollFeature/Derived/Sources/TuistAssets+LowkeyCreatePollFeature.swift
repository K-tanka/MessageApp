// swiftlint:disable all
// swift-format-ignore-file
// swiftformat:disable all
// Generated using tuist — https://github.com/tuist/tuist

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif
#if canImport(SwiftUI)
  import SwiftUI
#endif

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
public enum LowkeyCreatePollFeatureAsset {
  public static let lkBlack1 = LowkeyCreatePollFeatureColors(name: "lkBlack1")
  public static let lkBlack2 = LowkeyCreatePollFeatureColors(name: "lkBlack2")
  public static let lkBlue = LowkeyCreatePollFeatureColors(name: "lkBlue")
  public static let lkDarkGray = LowkeyCreatePollFeatureColors(name: "lkDarkGray")
  public static let pencilTipCropCircleBadgePlus = LowkeyCreatePollFeatureImages(name: "pencil.tip.crop.circle.badge.plus")
  public static let rectangleAndPencilAndEllipsis = LowkeyCreatePollFeatureImages(name: "rectangle.and.pencil.and.ellipsis")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

public final class LowkeyCreatePollFeatureColors {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  public private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  #if canImport(SwiftUI)
  private var _swiftUIColor: Any? = nil
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  public private(set) var swiftUIColor: SwiftUI.Color {
    get {
      if self._swiftUIColor == nil {
        self._swiftUIColor = SwiftUI.Color(asset: self)
      }

      return self._swiftUIColor as! SwiftUI.Color
    }
    set {
      self._swiftUIColor = newValue
    }
  }
  #endif

  fileprivate init(name: String) {
    self.name = name
  }
}

public extension LowkeyCreatePollFeatureColors.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: LowkeyCreatePollFeatureColors) {
    let bundle = LowkeyCreatePollFeatureResources.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
public extension SwiftUI.Color {
  init(asset: LowkeyCreatePollFeatureColors) {
    let bundle = LowkeyCreatePollFeatureResources.bundle
    self.init(asset.name, bundle: bundle)
  }
}
#endif

public struct LowkeyCreatePollFeatureImages {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Image = UIImage
  #endif

  public var image: Image {
    let bundle = LowkeyCreatePollFeatureResources.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let image = bundle.image(forResource: NSImage.Name(name))
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  public var swiftUIImage: SwiftUI.Image {
    SwiftUI.Image(asset: self)
  }
  #endif
}

public extension LowkeyCreatePollFeatureImages.Image {
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the LowkeyCreatePollFeatureImages.image property")
  convenience init?(asset: LowkeyCreatePollFeatureImages) {
    #if os(iOS) || os(tvOS)
    let bundle = LowkeyCreatePollFeatureResources.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
public extension SwiftUI.Image {
  init(asset: LowkeyCreatePollFeatureImages) {
    let bundle = LowkeyCreatePollFeatureResources.bundle
    self.init(asset.name, bundle: bundle)
  }

  init(asset: LowkeyCreatePollFeatureImages, label: Text) {
    let bundle = LowkeyCreatePollFeatureResources.bundle
    self.init(asset.name, bundle: bundle, label: label)
  }

  init(decorative asset: LowkeyCreatePollFeatureImages) {
    let bundle = LowkeyCreatePollFeatureResources.bundle
    self.init(decorative: asset.name, bundle: bundle)
  }
}
#endif

// swiftlint:enable all
// swiftformat:enable all
