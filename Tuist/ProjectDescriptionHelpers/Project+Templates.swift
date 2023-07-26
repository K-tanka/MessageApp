import ProjectDescription

public enum AppConfiguration {
    public static let projectName: String = "LowkeyTest"
    public static let bundleIdPrefix: String = "com.lowkey"
    public static let bundleIdApp: String = "\(bundleIdPrefix).ios"
    public static let deploymentTarget: DeploymentTarget = .iOS(targetVersion: "13.0", devices: .iphone)
}

// MARK: Scripts

public extension TargetScript {
    static var switlintScript: TargetScript = .pre(
        tool: "tuist", arguments: "lint", name: "SwiftLint", basedOnDependencyAnalysis: false
    )
}


public enum AppModules: String {
    case createPollFeature = "LowkeyCreatePollFeature"
    case sharedResources = "LowkeySharedResources"
    case sharedUIComponents = "LowkeySharedUIComponents"
    case chatFeature = "LowkeyChatFeature"
    case core = "LowkeyCore"
    case inputField = "LowkeyInputFieldFeature"

    public static func modulePath(module: Self) -> ProjectDescription.Path {
        return .relativeToRoot("components/\(module.rawValue)")
    }
}
