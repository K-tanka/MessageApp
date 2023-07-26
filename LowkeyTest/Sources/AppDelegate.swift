import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    private lazy var dependencyContainer = DependencyContainer()
    private lazy var applicationRouter = ApplicationRouter(dependencyContainer: dependencyContainer)

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = applicationRouter.startMainFlow()
        window?.makeKeyAndVisible()
        return true
    }
}
