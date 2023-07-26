import Foundation

final class PollOptionCellViewModel {
    weak var view: PollOptionCell?

    func getOptionText() -> String {
        guard let view = view else {
            assertionFailure()
            return ""
        }
        return view.getOptionText()
    }
}
