import UIKit

public protocol LowkeyChatFeatureOutputServices {
    func createChatViewController() -> UIViewController
}

public final class LowkeyChatFeatureOutputServicesImpl: LowkeyChatFeatureOutputServices {

    private let injection: LowkeyChatFeatureDependencies

    public init(injection: LowkeyChatFeatureDependencies) {
        self.injection = injection
    }

    public func createChatViewController() -> UIViewController {
        let model = ChatViewControllerModelImpl()
        let inputFieldView = injection.inputFieldFactory.createInputField(delegate: model)
        let chatViewController = ChatViewController(viewModel: model,
                                                    inputField: inputFieldView)
        let router = ChatViewControllerRouterImpl(rootViewController: chatViewController,
                                                  injection: injection)
        router.model = model
        model.controller = chatViewController
        model.router = router
        return chatViewController
    }
}
