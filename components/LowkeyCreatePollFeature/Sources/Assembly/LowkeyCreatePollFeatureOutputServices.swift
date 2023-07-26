import UIKit

public protocol LowkeyCreatePollFeatureDelegate: AnyObject {
    func didCloseTapped(_ controller: UIViewController)
    func didCreatePollTapped(_ controller: UIViewController, _ poll: Poll)
}

public protocol LowkeyCreatePollFeatureOutputServices {
    func createPoolFeatureController(delegate: LowkeyCreatePollFeatureDelegate) -> UIViewController
}

// swiftlint:disable type_name
public class LowkeyCreatePollFeatureOutputServicesImpl: LowkeyCreatePollFeatureOutputServices {
    public func createPoolFeatureController(delegate: LowkeyCreatePollFeatureDelegate) -> UIViewController {
        let model = CreatePollViewControllerModelImpl(delegate: delegate)
        let controller = CreatePollViewController(viewModel: model)
        model.controller = controller
        return controller
    }

    public init() {}
}
