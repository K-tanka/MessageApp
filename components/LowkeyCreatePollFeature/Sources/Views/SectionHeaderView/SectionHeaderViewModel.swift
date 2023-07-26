import Foundation

final class SectionHeaderViewModel {

    weak var view: SectionHeaderView?
    private let maxValue: Int
    private let title: String
    private var currentValue = 0

    init(title: String, maxValue: Int) {
        self.maxValue = maxValue
        self.title = title
    }

    func updateCounterLabel(currentValue: Int) {
        guard currentValue <= maxValue else {
            assertionFailure("Unexpected behaviour")
            return
        }
        let counterLabelString = "\(currentValue)/\(maxValue)"
        self.currentValue = currentValue
        view?.setCounterLabelText(counterLabelString)
    }

    func setTitleLabel() {
        view?.setTitleLabel(title)
    }

    func setupInitialState() {
        setTitleLabel()
        updateCounterLabel(currentValue: currentValue)
    }
}
