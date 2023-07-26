import UIKit

protocol PollCellViewModel: ChatCellModel {
    
    var ownerName: String { get }
    var ownerIcon: UIImage? { get }
    var question: String { get }
    var options: [String] { get }
    var votesNumber: Int { get set }

    func updateVotesNumber()
}

final class PollCellViewModelImpl: PollCellViewModel {

    let ownerName: String
    let ownerIcon: UIImage?
    let question: String
    let options: [String]
    var votesNumber: Int = 0

    init(ownerName: String,
         ownerIcon: UIImage?,
         question: String,
         options: [String]) {
        self.ownerName = ownerName
        self.ownerIcon = ownerIcon
        self.question = question
        self.options = options
    }

    func updateVotesNumber() {
        votesNumber += 1
    }
}
