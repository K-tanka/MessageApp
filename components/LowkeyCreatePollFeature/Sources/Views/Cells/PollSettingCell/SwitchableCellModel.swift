import Foundation

enum PollSettingCellType: UInt8 {
    case anonymous = 0
    case addMoreOptions
}

final class SwitchableCellModel {

    let type: PollSettingCellType
    let title: String
    var isOn: Bool = false

    init(type: PollSettingCellType,
         title: String) {
        self.type = type
        self.title = title
    }
}
