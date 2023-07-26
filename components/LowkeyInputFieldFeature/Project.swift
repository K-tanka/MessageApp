import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "LowkeyInputFieldFeature",
    targets: [
        Target(
            name: "LowkeyInputFieldFeature",
            platform: .iOS,
            product: .staticFramework,
            bundleId: "\(AppConfiguration.bundleIdApp).LowkeyInputFieldFeature",
            deploymentTarget: AppConfiguration.deploymentTarget,
            infoPlist: .default,
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            scripts: [
                .switlintScript
            ],
            dependencies: [
                .project(target: AppModules.core.rawValue,
                         path: AppModules.modulePath(module: .core)),
            ]
        ),
        Target(
            name: "LowkeyInputFieldFeatureTests",
            platform: .iOS,
            product: .unitTests,
            bundleId: "\(AppConfiguration.bundleIdApp).LowkeyInputFieldFeatureTests",
            deploymentTarget: AppConfiguration.deploymentTarget,
            infoPlist: .default,
            sources: ["Tests/**"],
            resources: [],
            dependencies: [.target(name: "LowkeyInputFieldFeature")]
        )
    ]
)
