import Foundation

enum NewPollFactory {

    private struct NewPoll: Poll {
        var question: String
        var options: [Option]
        var isAnonymous: Bool
        var isAbleAddMoreOptions: Bool
    }

    static func createPoll(question: String,
                           options: [PollOptionCellViewModel],
                           isAnonymous: Bool,
                           isAbleAddMoreOptions: Bool) -> Poll {
        let pollOptions = options.map({ PollOption(title: $0.getOptionText() )})
        return NewPoll(question: question,
                       options: pollOptions,
                       isAnonymous: isAnonymous,
                       isAbleAddMoreOptions: isAbleAddMoreOptions)
    }
}
