import Foundation
import LowkeyInputFieldFeature
import LowkeyCreatePollFeature
import LowkeySharedResources

protocol ChatViewControllerModel: ChatHeaderViewDelegate {
    func pollWasCreated(_ poll: LowkeyCreatePollFeature.Poll)
    func numberOfRows() -> Int
    func typeForRow(_ index: Int) -> RowType?
    func modelForChatCell(at index: Int) -> ChatCellModel?
}

enum RowType {
    case textMessage
    case poll
}

final class ChatViewControllerModelImpl: ChatViewControllerModel {
    
    private enum Constants {
        static let optionsSection = 0
        static let ownerName = "Leo Fox"
        static let ownerIcon = LowkeySharedResourcesAsset.avataaars.image
    }

    weak var controller: ChatViewController?
    var router: ChatViewControllerRouter?
    
    init() {
        createDefaultTextMessageCellModel()
    }
    
    private var chatCellsViewModels = [ChatCellModel]()
    
    func pollWasCreated(_ poll: LowkeyCreatePollFeature.Poll) {
        createNewPoll(poll)
    }
    
    func numberOfRows() -> Int {
        return chatCellsViewModels.count
    }
    
    func typeForRow(_ index: Int) -> RowType? {
        guard let model = chatCellsViewModels[safe: index] else {
            assertionFailure()
            return nil
        }
        switch model {
        case _ as TextMessageCellModel:
            return .textMessage
        case _ as PollCellViewModel:
            return .poll
        default:
            return nil
        }
    }
    
    func modelForChatCell(at index: Int) -> ChatCellModel? {
        chatCellsViewModels[safe: index]
    }
    
    private func createDefaultTextMessageCellModel() {
        for _ in 1...15 {
            let avatar = LowkeySharedResources.RandomAvatarProvider.randomAvatarProvider()
            let name = LowkeySharedResources.RandomNameProvider.randomName()
            let message = LowkeySharedResources.RandomMessageProvider.randomMessage()
            let model = TextMessageCellModelImpl(icon: avatar, name: name, message: message)
            chatCellsViewModels.append(model)
        }
    }
    
    private func handleMessageTapped(_ message: String) {
        let model = TextMessageCellModelImpl(icon: LowkeySharedResourcesAsset.avataaars
            .image, name: Constants.ownerName, message: message)
        chatCellsViewModels.append(model)
        updateRows()
    }
    
    private func createNewPoll(_ poll: LowkeyCreatePollFeature.Poll) {
        let model = PollCellViewModelImpl(ownerName: Constants.ownerName, ownerIcon: Constants.ownerIcon, question: poll.question, options: poll.options.map({ $0.title }))
        chatCellsViewModels.append(model)
        updateRows()
    }
    
    private func updateRows() {
        let lastIndex = chatCellsViewModels.count - 1
        controller?.insertRows(at: IndexPath(row: lastIndex, section: Constants.optionsSection))
    }
}

extension ChatViewControllerModelImpl: LowkeyInputFieldDelegate {

    func userIsTyping() {
        controller?.updateLayoutIfNeeded()
    }

    func createPollTapped() {
        router?.showPoolViewController()
    }

    func sendMessageTapped(_ message: String) {
        handleMessageTapped(message)
    }
}

extension ChatViewControllerModelImpl: ChatHeaderViewDelegate {
    
    func didTapCloseButton() {
        print("didTapCloseButton")
    }
}
