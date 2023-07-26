import ProjectDescription
import ProjectDescriptionHelpers


let appBaseId = "\(AppConfiguration.bundleIdApp).\(AppConfiguration.projectName)"

let project = Project(
    name: AppConfiguration.projectName,
    targets: [
        Target(
            name: AppConfiguration.projectName,
            platform: .iOS,
            product: .app,
            bundleId: appBaseId,
            deploymentTarget: AppConfiguration.deploymentTarget,
            infoPlist: .file(path: "LowkeyTest-Info.plist"),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            scripts: [
                .switlintScript
            ],
            dependencies: [
                .project(target: AppModules.chatFeature.rawValue,
                         path: AppModules.modulePath(module: .chatFeature)),
                .project(target: AppModules.createPollFeature.rawValue,
                         path: AppModules.modulePath(module: .createPollFeature)),
                .project(target: AppModules.core.rawValue,
                         path: AppModules.modulePath(module: .core)),
                .project(target: AppModules.inputField.rawValue,
                         path: AppModules.modulePath(module: .inputField)),
            ]
        )
    ],
    resourceSynthesizers: [
        .fonts(),
        .strings(),
        .assets()
    ]
)
