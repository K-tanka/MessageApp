import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "LowkeyCore",
    targets: [
        Target(
            name: "LowkeyCore",
            platform: .iOS,
            product: .staticFramework,
            bundleId: "\(AppConfiguration.bundleIdApp).LowkeyCore",
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
            name: "LowkeyCoreTests",
            platform: .iOS,
            product: .unitTests,
            bundleId: "\(AppConfiguration.bundleIdApp).LowkeyCoreTests",
            deploymentTarget: AppConfiguration.deploymentTarget,
            infoPlist: .default,
            sources: ["Tests/**"],
            resources: [],
            dependencies: [.target(name: "LowkeyCore")]
        )
    ]
)
