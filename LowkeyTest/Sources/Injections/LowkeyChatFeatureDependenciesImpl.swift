import LowkeyChatFeature
import LowkeyInputFieldFeature
import LowkeyCreatePollFeature

final class LowkeyChatFeatureDependenciesImpl: LowkeyChatFeatureDependencies {

    private let container: DependencyContainer

    init(container: DependencyContainer) {
        self.container = container
    }

    var poolFactory: LowkeyCreatePollFeature.LowkeyCreatePollFeatureOutputServices {
        return container.poolFactory
    }

    var inputFieldFactory: LowkeyInputFieldFeature.LowkeyInputFieldFeatureOutputServices {
        container.inputFieldFactory
    }
}
