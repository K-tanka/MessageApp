import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "LowkeySharedUIComponents",
    targets: [
        Target(
            name: "LowkeySharedUIComponents",
            platform: .iOS,
            product: .framework,
            bundleId: "\(AppConfiguration.bundleIdApp).LowkeySharedUIComponents",
            deploymentTarget: AppConfiguration.deploymentTarget,
            infoPlist: .default,
            sources: ["Sources/**"],
            scripts: [
                .switlintScript
            ],
            dependencies: [
            ]
        ),
        Target(
            name: "LowkeySharedUIComponentsTests",
            platform: .iOS,
            product: .unitTests,
            bundleId: "\(AppConfiguration.bundleIdApp).LowkeySharedUIComponentsTests",
            deploymentTarget: AppConfiguration.deploymentTarget,
            infoPlist: .default,
            sources: ["Tests/**"],
            resources: [],
            dependencies: [.target(name: "LowkeySharedUIComponents")]
        )
    ]
)
