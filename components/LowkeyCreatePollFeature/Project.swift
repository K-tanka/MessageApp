import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "LowkeyCreatePollFeature",
    targets: [
        Target(
            name: "LowkeyCreatePollFeature",
            platform: .iOS,
            product: .staticFramework,
            bundleId: "\(AppConfiguration.bundleIdApp).LowkeyCreatePollFeature",
            deploymentTarget: AppConfiguration.deploymentTarget,
            infoPlist: .default,
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            scripts: [
                .switlintScript
            ],
            dependencies: [
                .project(target: AppModules.sharedResources.rawValue, path: AppModules.modulePath(module: .sharedResources)),
                .project(target: AppModules.sharedUIComponents.rawValue, path: AppModules.modulePath(module: .sharedUIComponents)),
                .project(target: AppModules.core.rawValue,
                         path: AppModules.modulePath(module: .core)),
            ]
        ),
        Target(
            name: "LowkeyCreatePollFeatureTests",
            platform: .iOS,
            product: .unitTests,
            bundleId: "\(AppConfiguration.bundleIdApp).LowkeyCreatePollFeatureTests",
            deploymentTarget: AppConfiguration.deploymentTarget,
            infoPlist: .default,
            sources: ["Tests/**"],
            resources: [],
            dependencies: [.target(name: "LowkeyCreatePollFeature")]
        )
    ]
)
