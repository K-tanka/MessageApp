import Foundation
import LowkeySharedUIComponents

protocol InputFieldViewModel: DynamicTextViewDelegate {
    func didTapOnPollButton()
    func didTapOnSendMessageButton(_ message: String)
}

final class InputFieldViewModelImpl: InputFieldViewModel {

    private weak var delegate: LowkeyInputFieldDelegate?
    weak var view: InputFieldView?

    init(delegate: LowkeyInputFieldDelegate) {
        self.delegate = delegate
    }

    func didTapOnPollButton() {
        delegate?.createPollTapped()
    }

    func didTapOnSendMessageButton(_ message: String) {
        guard !message.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        delegate?.sendMessageTapped(message)
        view?.clearTextView()
    }

    func numberEnteredСharacters(_ number: Int) {
        delegate?.userIsTyping()
    }

    func didBeginEditing() {}
    func didEndEditing() {}
}
