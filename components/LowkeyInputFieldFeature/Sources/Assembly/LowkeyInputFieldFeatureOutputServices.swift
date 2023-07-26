import UIKit

public protocol LowkeyInputFieldDelegate: AnyObject {
    func createPollTapped()
    func sendMessageTapped(_ message: String)
    func userIsTyping()
}

public protocol LowkeyInputFieldFeatureOutputServices {
    func createInputField(delegate: LowkeyInputFieldDelegate) -> UIView
}

// swiftlint:disable type_name
public final class LowkeyInputFieldFeatureOutputServicesImpl: LowkeyInputFieldFeatureOutputServices {

    public func createInputField(delegate: LowkeyInputFieldDelegate) -> UIView {
        let model = InputFieldViewModelImpl(delegate: delegate)
        let view = InputFieldView(viewModel: model)
        model.view = view
        return view
    }
    public init() {}
}
