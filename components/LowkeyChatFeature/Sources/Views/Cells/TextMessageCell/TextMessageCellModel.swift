import UIKit
import LowkeySharedResources

protocol ChatCellModel {}

protocol TextMessageCellModel: ChatCellModel {
    
    var icon: UIImage? { get }
    var name: String { get }
    var message: String { get }
}

final class TextMessageCellModelImpl: TextMessageCellModel {
    
    public let icon: UIImage?
    public let name: String
    public let message: String
    
    public init(icon: UIImage?, name: String, message: String) {
        self.icon = icon
        self.name = name
        self.message = message
    }
}
