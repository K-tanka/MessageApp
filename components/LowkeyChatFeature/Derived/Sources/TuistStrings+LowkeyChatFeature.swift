// swiftlint:disable all
// swift-format-ignore-file
// swiftformat:disable all
// Generated using tuist — https://github.com/tuist/tuist

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
public enum LowkeyChatFeatureStrings {

  public enum Chat {
    public enum Header {
      /// Lowkey Squad
      public static let title = LowkeyChatFeatureStrings.tr("Localizable", "chat.header.title")
      public enum Subtitle {
        /// %d members * %d online
        public static func format(_ p1: Int, _ p2: Int) -> String {
          return LowkeyChatFeatureStrings.tr("Localizable", "chat.header.subtitle.format", p1, p2)
        }
      }
    }
    public enum Public {
      public enum Poll {
        /// Public poll
        public static let title = LowkeyChatFeatureStrings.tr("Localizable", "chat.public.poll.title")
      }
    }
    public enum Vote {
      public enum Result {
        public enum VotesNumber {
          /// %d\nvotes
          public static func format(_ p1: Int) -> String {
            return LowkeyChatFeatureStrings.tr("Localizable", "chat.vote.result.votesNumber.format", p1)
          }
        }
      }
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension LowkeyChatFeatureStrings {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = LowkeyChatFeatureResources.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
// swiftlint:enable all
// swiftformat:enable all
