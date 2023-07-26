import LowkeyInputFieldFeature
import LowkeyCreatePollFeature

public protocol LowkeyChatFeatureDependencies {
    var poolFactory: LowkeyCreatePollFeatureOutputServices { get }
    var inputFieldFactory: LowkeyInputFieldFeatureOutputServices { get }
}
