import Foundation
import LowkeyCreatePollFeature
import LowkeyInputFieldFeature
import LowkeyChatFeature

// swiftlint:disable line_length
final class DependencyContainer {
    lazy var poolFactory: LowkeyCreatePollFeatureOutputServices = LowkeyCreatePollFeatureOutputServicesImpl()
    lazy var inputFieldFactory: LowkeyInputFieldFeatureOutputServices = LowkeyInputFieldFeatureOutputServicesImpl()
    lazy var chatListFactory: LowkeyChatFeatureOutputServices = LowkeyChatFeatureOutputServicesImpl(injection: LowkeyChatFeatureDependenciesImpl(container: self))
}
// swiftlint:enable line_length
