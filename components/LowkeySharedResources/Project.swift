import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "LowkeySharedResources",
    targets: [
        Target(
            name: "LowkeySharedResources",
            platform: .iOS,
            product: .framework,
            bundleId: "\(AppConfiguration.bundleIdApp).LowkeySharedResources",
            deploymentTarget: AppConfiguration.deploymentTarget,
            infoPlist: .default,
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            scripts: [
                .switlintScript
            ],
            dependencies: [
            ]
        )
    ]
)
