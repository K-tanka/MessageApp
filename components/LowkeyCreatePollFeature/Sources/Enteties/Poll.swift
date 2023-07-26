import Foundation

public protocol Option {
    var title: String { get }
}

struct PollOption: Option {
    var title: String
}

public protocol Poll {
    var question: String { get }
    var options: [Option] { get }

    var isAnonymous: Bool { get }
    var isAbleAddMoreOptions: Bool { get }
}
