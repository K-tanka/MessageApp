// swiftlint:disable all
// swift-format-ignore-file
// swiftformat:disable all
// Generated using tuist — https://github.com/tuist/tuist

#if os(macOS)
  import AppKit.NSFont
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIFont
#endif
#if canImport(SwiftUI)
  import SwiftUI
#endif

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Fonts

// swiftlint:disable identifier_name line_length type_body_length
public enum LowkeySharedResourcesFontFamily {
  public enum Poppins {
    public static let bold = LowkeySharedResourcesFontConvertible(name: "Poppins-Bold", family: "Poppins", path: "Poppins-Bold.ttf")
    public static let boldItalic = LowkeySharedResourcesFontConvertible(name: "Poppins-BoldItalic", family: "Poppins", path: "Poppins-BoldItalic.ttf")
    public static let italic = LowkeySharedResourcesFontConvertible(name: "Poppins-Italic", family: "Poppins", path: "Poppins-Italic.ttf")
    public static let regular = LowkeySharedResourcesFontConvertible(name: "Poppins-Regular", family: "Poppins", path: "Poppins-Regular.ttf")
    public static let all: [LowkeySharedResourcesFontConvertible] = [bold, boldItalic, italic, regular]
  }
  public enum PoppinsBlack {
    public static let regular = LowkeySharedResourcesFontConvertible(name: "Poppins-Black", family: "Poppins Black", path: "Poppins-Black.ttf")
    public static let italic = LowkeySharedResourcesFontConvertible(name: "Poppins-BlackItalic", family: "Poppins Black", path: "Poppins-BlackItalic.ttf")
    public static let all: [LowkeySharedResourcesFontConvertible] = [regular, italic]
  }
  public enum PoppinsExtraBold {
    public static let regular = LowkeySharedResourcesFontConvertible(name: "Poppins-ExtraBold", family: "Poppins ExtraBold", path: "Poppins-ExtraBold.ttf")
    public static let italic = LowkeySharedResourcesFontConvertible(name: "Poppins-ExtraBoldItalic", family: "Poppins ExtraBold", path: "Poppins-ExtraBoldItalic.ttf")
    public static let all: [LowkeySharedResourcesFontConvertible] = [regular, italic]
  }
  public enum PoppinsExtraLight {
    public static let regular = LowkeySharedResourcesFontConvertible(name: "Poppins-ExtraLight", family: "Poppins ExtraLight", path: "Poppins-ExtraLight.ttf")
    public static let italic = LowkeySharedResourcesFontConvertible(name: "Poppins-ExtraLightItalic", family: "Poppins ExtraLight", path: "Poppins-ExtraLightItalic.ttf")
    public static let all: [LowkeySharedResourcesFontConvertible] = [regular, italic]
  }
  public enum PoppinsLight {
    public static let regular = LowkeySharedResourcesFontConvertible(name: "Poppins-Light", family: "Poppins Light", path: "Poppins-Light.ttf")
    public static let italic = LowkeySharedResourcesFontConvertible(name: "Poppins-LightItalic", family: "Poppins Light", path: "Poppins-LightItalic.ttf")
    public static let all: [LowkeySharedResourcesFontConvertible] = [regular, italic]
  }
  public enum PoppinsMedium {
    public static let regular = LowkeySharedResourcesFontConvertible(name: "Poppins-Medium", family: "Poppins Medium", path: "Poppins-Medium.ttf")
    public static let italic = LowkeySharedResourcesFontConvertible(name: "Poppins-MediumItalic", family: "Poppins Medium", path: "Poppins-MediumItalic.ttf")
    public static let all: [LowkeySharedResourcesFontConvertible] = [regular, italic]
  }
  public enum PoppinsSemiBold {
    public static let regular = LowkeySharedResourcesFontConvertible(name: "Poppins-SemiBold", family: "Poppins SemiBold", path: "Poppins-SemiBold.ttf")
    public static let italic = LowkeySharedResourcesFontConvertible(name: "Poppins-SemiBoldItalic", family: "Poppins SemiBold", path: "Poppins-SemiBoldItalic.ttf")
    public static let all: [LowkeySharedResourcesFontConvertible] = [regular, italic]
  }
  public enum PoppinsThin {
    public static let regular = LowkeySharedResourcesFontConvertible(name: "Poppins-Thin", family: "Poppins Thin", path: "Poppins-Thin.ttf")
    public static let italic = LowkeySharedResourcesFontConvertible(name: "Poppins-ThinItalic", family: "Poppins Thin", path: "Poppins-ThinItalic.ttf")
    public static let all: [LowkeySharedResourcesFontConvertible] = [regular, italic]
  }
  public static let allCustomFonts: [LowkeySharedResourcesFontConvertible] = [Poppins.all, PoppinsBlack.all, PoppinsExtraBold.all, PoppinsExtraLight.all, PoppinsLight.all, PoppinsMedium.all, PoppinsSemiBold.all, PoppinsThin.all].flatMap { $0 }
  public static func registerAllCustomFonts() {
    allCustomFonts.forEach { $0.register() }
  }
}
// swiftlint:enable identifier_name line_length type_body_length

// MARK: - Implementation Details

public struct LowkeySharedResourcesFontConvertible {
  public let name: String
  public let family: String
  public let path: String

  #if os(macOS)
  public typealias Font = NSFont
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Font = UIFont
  #endif

  public func font(size: CGFloat) -> Font {
    guard let font = Font(font: self, size: size) else {
      fatalError("Unable to initialize font '\(name)' (\(family))")
    }
    return font
  }

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  public func swiftUIFont(size: CGFloat) -> SwiftUI.Font {
    guard let font = Font(font: self, size: size) else {
      fatalError("Unable to initialize font '\(name)' (\(family))")
    }
    #if os(macOS)
    return SwiftUI.Font.custom(font.fontName, size: font.size)
    #elseif os(iOS) || os(tvOS) || os(watchOS)
    return SwiftUI.Font(font)
    #endif
  }
  #endif

  public func register() {
    // swiftlint:disable:next conditional_returns_on_newline
    guard let url = url else { return }
    CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
  }

  fileprivate var url: URL? {
    // swiftlint:disable:next implicit_return
    return Bundle.module.url(forResource: path, withExtension: nil)
  }
}

public extension LowkeySharedResourcesFontConvertible.Font {
  convenience init?(font: LowkeySharedResourcesFontConvertible, size: CGFloat) {
    #if os(iOS) || os(tvOS) || os(watchOS)
    if !UIFont.fontNames(forFamilyName: font.family).contains(font.name) {
      font.register()
    }
    #elseif os(macOS)
    if let url = font.url, CTFontManagerGetScopeForURL(url as CFURL) == .none {
      font.register()
    }
    #endif

    self.init(name: font.name, size: size)
  }
}
// swiftlint:enable all
// swiftformat:enable all
