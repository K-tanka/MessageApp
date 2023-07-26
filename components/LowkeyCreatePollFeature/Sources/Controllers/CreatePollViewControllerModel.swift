import Foundation
import LowkeyCore

protocol CreatePollViewControllerModel: AddOptionFooterViewDelegate, CreatePollHeaderViewDelegate {
    var questionCellViewModel: QuestionCellViewModel { get }

    func numberOfSections() -> Int
    func numberOfRowsInSection(section: Int) -> Int

    func typeForSection(section: Int) -> SectionType?
    func removeOption(at indexPath: IndexPath)
    func isNeedCreateFooterFor(section: Int) -> Bool
    func viewModelForHeader(at section: Int) -> SectionHeaderViewModel?
    func modelForSettingSection(at index: Int) -> SwitchableCellModel?
    func modelForOptionsSection(at index: Int) -> PollOptionCellViewModel?
}

enum SectionType: Int {
    case question = 0
    case option
    case settings
}

final class CreatePollViewControllerModelImpl: CreatePollViewControllerModel {
    private enum Constants {
        static let questionSection = 0
        static let optionsSection = 1
        static let settingsSection = 2

        static let numberOfSections = 3
        static let questionCharactersLimit = 140
        static let optionsNumberLimit = 8
    }

    var controller: CreatePollViewController?
    private weak var delegate: LowkeyCreatePollFeatureDelegate?

    private lazy var questionHeaderViewModel: SectionHeaderViewModel = {
        let model = SectionHeaderViewModel(title: LowkeyCreatePollFeatureStrings.Create.Poll.Question.Header.title,
                                           maxValue: Constants.questionCharactersLimit)
        return model
    }()

    private lazy var optionsHeaderViewModel: SectionHeaderViewModel = {
        let model = SectionHeaderViewModel(title: LowkeyCreatePollFeatureStrings.Create.Poll.Options.Header.title,
                                           maxValue: Constants.optionsNumberLimit)
        return model
    }()

    lazy var questionCellViewModel: QuestionCellViewModel = {
        let model = QuestionCellViewModel()
        model.sectionHeader = questionHeaderViewModel
        return model
    }()

    private lazy var anonymousSettingModel: SwitchableCellModel = {
        let title = LowkeyCreatePollFeatureStrings.Create.Poll.Question.Anonymous.setting
        return SwitchableCellModel(type: .anonymous, title: title)
    }()

    private lazy var addMoreModel: SwitchableCellModel = {
        let title = LowkeyCreatePollFeatureStrings.Create.Poll.Question.Ability.More.setting
        return SwitchableCellModel(type: .addMoreOptions, title: title)
    }()

    private var optionCellsViewModels = [PollOptionCellViewModel]()

    init(delegate: LowkeyCreatePollFeatureDelegate) {
        self.delegate = delegate
    }

    func typeForSection(section: Int) -> SectionType? {
        return SectionType(rawValue: section)
    }

    func numberOfSections() -> Int {
        Constants.numberOfSections
    }

    func isNeedCreateFooterFor(section: Int) -> Bool {
        section == Constants.optionsSection
    }

    func viewModelForHeader(at section: Int) -> SectionHeaderViewModel? {
        guard let type = typeForSection(section: section) else {
            assertionFailure()
            return nil
        }
        switch type {
        case .question: return questionHeaderViewModel
        case .option: return optionsHeaderViewModel
        case .settings: return nil
        }
    }

    func numberOfRowsInSection(section: Int) -> Int {
        guard let type = typeForSection(section: section) else {
            assertionFailure()
            return .zero
        }

        switch type {
        case .question: return 1
        case .option: return optionCellsViewModels.count
        case .settings: return 2
        }
    }

    func modelForSettingSection(at index: Int) -> SwitchableCellModel? {
        guard let type = PollSettingCellType(rawValue: UInt8(index)) else {
            assertionFailure()
            return nil
        }
        switch type {
        case .anonymous: return anonymousSettingModel
        case .addMoreOptions: return addMoreModel
        }
    }

    func modelForOptionsSection(at index: Int) -> PollOptionCellViewModel? {
        optionCellsViewModels[safe: index]
    }

    func removeOption(at indexPath: IndexPath) {
        guard optionCellsViewModels[safe: indexPath.row] != nil else {
            assertionFailure()
            return
        }
        optionCellsViewModels.remove(at: indexPath.row)
        controller?.deleteRows(at: indexPath)
        updateOptionsSectionHeader()
    }
}

extension CreatePollViewControllerModelImpl: AddOptionFooterViewDelegate {
    func addOptionButtonTapped() {
        guard optionCellsViewModels.count < Constants.optionsNumberLimit else {
            assertionFailure("Show alert about options limit!")
            return
        }
        optionCellsViewModels.append(PollOptionCellViewModel())
        updateOptionsSectionHeader()
        let lastIndex = optionCellsViewModels.count - 1
        controller?.insertRows(at: IndexPath(row: lastIndex, section: Constants.optionsSection))
    }

    private func updateOptionsSectionHeader() {
        optionsHeaderViewModel.updateCounterLabel(currentValue: optionCellsViewModels.count)
    }
}

extension CreatePollViewControllerModelImpl: CreatePollHeaderViewDelegate {
    func didTapCloseButton() {
        guard let controller = controller else {
            assertionFailure()
            return
        }
        delegate?.didCloseTapped(controller)
    }

    func didTapDoneButton() {
        guard let controller = controller else {
            assertionFailure()
            return
        }

        let poll = NewPollFactory.createPoll(question: questionCellViewModel.questionText(),
                                             options: optionCellsViewModels,
                                             isAnonymous: anonymousSettingModel.isOn,
                                             isAbleAddMoreOptions: addMoreModel.isOn)
        do {
            try PollValidator.isValidatePool(poll)
            delegate?.didCreatePollTapped(controller, poll)
        } catch {
            assertionFailure("Not valid poll handle error \(error)")
        }
    }
}
