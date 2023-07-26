import UIKit
import LowkeySharedResources
import LowkeySharedUIComponents

final class TextMessageCell: UITableViewCell, ReusableView {
    
    private enum Constants {
        static let nameTextColor = UIColor.gray
        static let messageTextColor = UIColor.white
        static let nameTextFont = LowkeyFont.regular(size: 12)
        static let messageTextFont = LowkeyFont.regular(size: 15)
        static let iconSize = CGSize(width: 45.0, height: 45.0)
        static let commonOffset = 16.0
        static let messageTextNumberOfLines = 0
        static let messageLabelOffset = 5.0
    }
    
    private lazy var icon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = Constants.commonOffset
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.nameTextFont
        label.textColor = Constants.nameTextColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.messageTextFont
        label.textColor = Constants.messageTextColor
        label.numberOfLines = Constants.messageTextNumberOfLines
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUIElements()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ cellModel: TextMessageCellModel?) {
        setupValues(cellModel)
        invalidateIntrinsicContentSize()
    }
    
    private func setupValues(_ cellModel: TextMessageCellModel?) {
        guard let cellModel = cellModel else { return }
        icon.image = cellModel.icon
        nameLabel.text = cellModel.name
        messageLabel.text = cellModel.message
    }
    
    private func setupUIElements() {
        contentView.addSubview(icon)
        contentView.addSubview(nameLabel)
        contentView.addSubview(messageLabel)

        NSLayoutConstraint.activate([
            icon.heightAnchor.constraint(equalToConstant: Constants.iconSize.height),
            icon.widthAnchor.constraint(equalToConstant: Constants.iconSize.width),
            icon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.messageLabelOffset),
            icon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.commonOffset),

            nameLabel.topAnchor.constraint(equalTo: icon.topAnchor, constant: Constants.messageLabelOffset),
            nameLabel.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: Constants.commonOffset),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -Constants.commonOffset),

            messageLabel.topAnchor.constraint(equalTo: icon.bottomAnchor, constant: -Constants.commonOffset),
            messageLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            messageLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            messageLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.messageLabelOffset)
        ])
    }
}
