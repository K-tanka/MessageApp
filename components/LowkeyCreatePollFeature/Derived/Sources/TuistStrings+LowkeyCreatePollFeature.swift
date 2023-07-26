// swiftlint:disable all
// swift-format-ignore-file
// swiftformat:disable all
// Generated using tuist — https://github.com/tuist/tuist

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
public enum LowkeyCreatePollFeatureStrings {

  public enum Chat {
    public enum Header {
      /// Lowkey Squad
      public static let title = LowkeyCreatePollFeatureStrings.tr("Localizable", "chat.header.title")
      public enum Subtitle {
        /// %d members * %d online
        public static func format(_ p1: Int, _ p2: Int) -> String {
          return LowkeyCreatePollFeatureStrings.tr("Localizable", "chat.header.subtitle.format", p1, p2)
        }
      }
    }
    public enum Poll {
      public enum Result {
        public enum VotesNumber {
          /// %d\nvotes
          public static func format(_ p1: Int) -> String {
            return LowkeyCreatePollFeatureStrings.tr("Localizable", "chat.poll.result.votesNumber.format", p1)
          }
        }
      }
    }
  }

  public enum Create {
    public enum Poll {
      public enum Header {
        /// New Poll
        public static let title = LowkeyCreatePollFeatureStrings.tr("Localizable", "create.poll.header.title")
        public enum Button {
          /// Create
          public static let title = LowkeyCreatePollFeatureStrings.tr("Localizable", "create.poll.header.button.title")
        }
      }
      public enum Options {
        public enum Header {
          /// Options
          public static let title = LowkeyCreatePollFeatureStrings.tr("Localizable", "create.poll.options.header.title")
        }
      }
      public enum Question {
        /// Add an option
        public static let footer = LowkeyCreatePollFeatureStrings.tr("Localizable", "create.poll.question.footer")
        /// Ask a question
        public static let placeholder = LowkeyCreatePollFeatureStrings.tr("Localizable", "create.poll.question.placeholder")
        public enum Ability {
          public enum More {
            /// Ability to add more options
            public static let setting = LowkeyCreatePollFeatureStrings.tr("Localizable", "create.poll.question.ability.more.setting")
          }
        }
        public enum Anonymous {
          /// Anonymous voting
          public static let setting = LowkeyCreatePollFeatureStrings.tr("Localizable", "create.poll.question.anonymous.setting")
        }
        public enum Header {
          /// Question
          public static let title = LowkeyCreatePollFeatureStrings.tr("Localizable", "create.poll.question.header.title")
        }
      }
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension LowkeyCreatePollFeatureStrings {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = LowkeyCreatePollFeatureResources.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
// swiftlint:enable all
// swiftformat:enable all
