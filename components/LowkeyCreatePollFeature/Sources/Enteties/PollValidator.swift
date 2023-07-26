import Foundation

enum PollValidator {
    enum ValidationError: Error {
        case invalidQuestion
        case invalidOption
        case emptyOptions
    }

    static func isValidatePool(_ poll: Poll) throws {
        guard !poll.question.isEmpty else {
            throw ValidationError.invalidQuestion
        }
        guard !poll.options.isEmpty else {
            throw ValidationError.emptyOptions
        }

        try validateOptions(options: poll.options)
    }

    private static func validateOptions(options: [Option]) throws {
        for option in options {
            try isValidOption(option)
        }
    }

    private static func isValidOption(_ option: Option) throws {
        guard !option.title.isEmpty else {
            throw ValidationError.invalidOption
        }
    }
}
