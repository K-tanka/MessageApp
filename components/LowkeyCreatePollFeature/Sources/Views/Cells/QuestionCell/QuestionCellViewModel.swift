import UIKit
import protocol LowkeySharedUIComponents.DynamicTextViewDelegate

final class QuestionCellViewModel: DynamicTextViewDelegate {
    weak var view: QuestionCell?
    weak var sectionHeader: SectionHeaderViewModel?

    func numberEnteredСharacters(_ number: Int) {
        sectionHeader?.updateCounterLabel(currentValue: number)
    }

    func didBeginEditing() {}
    func didEndEditing() {}

    func questionText() -> String {
        guard let view = view else {
            assertionFailure()
            return ""
        }
        return view.getQuestionText()
    }
}
