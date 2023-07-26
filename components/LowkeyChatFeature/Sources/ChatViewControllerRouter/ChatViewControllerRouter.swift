import UIKit
import LowkeyCreatePollFeature

protocol ChatViewControllerRouter {
    func showPoolViewController()
}

final class ChatViewControllerRouterImpl: ChatViewControllerRouter {

    private let rootViewController: UIViewController
    private let injection: LowkeyChatFeatureDependencies
    weak var model: ChatViewControllerModel?

    init(rootViewController: UIViewController,
         injection: LowkeyChatFeatureDependencies) {
        self.rootViewController = rootViewController
        self.injection = injection
    }

    func showPoolViewController() {
        let pollController = injection.poolFactory.createPoolFeatureController(delegate: self)
        pollController.modalPresentationStyle = .formSheet
        rootViewController.present(pollController, animated: true)
    }

    func dismissController(_ controller: UIViewController) {
        controller.dismiss(animated: true)
    }
}

extension ChatViewControllerRouterImpl: LowkeyCreatePollFeatureDelegate {
    func didCloseTapped(_ controller: UIViewController) {
        dismissController(controller)
    }

    func didCreatePollTapped(_ controller: UIViewController, _ poll: LowkeyCreatePollFeature.Poll) {
        model?.pollWasCreated(poll)
        dismissController(controller)
    }
}
