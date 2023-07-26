import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "LowkeyChatFeature",
    targets: [
        Target(
            name: "LowkeyChatFeature",
            platform: .iOS,
            product: .staticFramework,
            bundleId: "\(AppConfiguration.bundleIdApp).LowkeyChatFeature",
            deploymentTarget: AppConfiguration.deploymentTarget,
            infoPlist: .default,
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            scripts: [
                .switlintScript
            ],
            dependencies: [
                .project(target: AppModules.sharedResources.rawValue,
                         path: AppModules.modulePath(module: .sharedResources)),
                .project(target: AppModules.sharedUIComponents.rawValue,
                         path: AppModules.modulePath(module: .sharedUIComponents)),
                .project(target: AppModules.createPollFeature.rawValue,
                         path: AppModules.modulePath(module: .createPollFeature)),
                .project(target: AppModules.core.rawValue,
                         path: AppModules.modulePath(module: .core)),
                .project(target: AppModules.inputField.rawValue,
                         path: AppModules.modulePath(module: .inputField)),
            ]
        ),
        Target(
            name: "LowkeyChatFeatureTests",
            platform: .iOS,
            product: .unitTests,
            bundleId: "\(AppConfiguration.bundleIdApp).LowkeyChatFeatureTests",
            deploymentTarget: AppConfiguration.deploymentTarget,
            infoPlist: .default,
            sources: ["Tests/**"],
            resources: [],
            dependencies: [.target(name: "LowkeyChatFeature")]
        )
    ]
)
