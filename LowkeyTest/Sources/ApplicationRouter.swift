import UIKit
import LowkeyChatFeature

final class ApplicationRouter {

    private let dependencyContainer: DependencyContainer
    private var rootViewController: UIViewController?

    init(dependencyContainer: DependencyContainer) {
        self.dependencyContainer = dependencyContainer
    }

    func startMainFlow() -> UIViewController {
        return dependencyContainer.chatListFactory.createChatViewController()
    }
}
