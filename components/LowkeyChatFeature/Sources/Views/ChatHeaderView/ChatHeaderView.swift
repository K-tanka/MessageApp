import UIKit
import LowkeySharedResources

protocol ChatHeaderView where Self: UIView {
    func updateMembersInfo(membersNumber: Int, onlineNumber: Int)
}

protocol ChatHeaderViewDelegate: AnyObject {
    func didTapCloseButton()
}

final class ChatHeaderViewImpl: UIView, ChatHeaderView {
    
    private enum Constants {
        static let iconOffset = 3.0
        static let commonOffset = 16.0
        static let iconSize = CGSize(width: 40.0, height: 40.0)
        static let titleTextColor = UIColor.white
        static let subtitleTextColor = UIColor.gray
        static let titleTextFont = LowkeyFont.regular(size: 15)
        static let subtitleTextFont = LowkeyFont.regular(size: 10)
    }
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(LowkeySharedResourcesAsset.xmark.image, for: .normal)
        button.tintColor = Constants.titleTextColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapedCloseButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.titleTextFont
        label.textColor = Constants.titleTextColor
        label.text = LowkeyChatFeatureStrings.Chat.Header.title
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.subtitleTextFont
        label.textColor = Constants.subtitleTextColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var icon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = LowkeySharedResourcesAsset.avataaars.image
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = Constants.iconSize.height / 2
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private weak var delegate: ChatHeaderViewDelegate?
    
    init(delegate: ChatHeaderViewDelegate) {
        self.delegate = delegate
        super.init(frame: .zero)
        backgroundColor = .systemBackground
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateMembersInfo(membersNumber: Int, onlineNumber: Int) {
        subtitleLabel.text = LowkeyChatFeatureStrings.Chat.Header.Subtitle.format(membersNumber, onlineNumber)
    }
    
    private func setupLayout() {
        addSubview(icon)
        addSubview(closeButton)
        addSubview(subtitleLabel)
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            icon.heightAnchor.constraint(equalToConstant: Constants.iconSize.height),
            icon.widthAnchor.constraint(equalToConstant: Constants.iconSize.width),
            icon.topAnchor.constraint(equalTo: topAnchor, constant: Constants.iconOffset),
            icon.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.commonOffset),
            icon.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.iconOffset),

            closeButton.centerYAnchor.constraint(equalTo: icon.centerYAnchor),
            closeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.commonOffset),

            subtitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            subtitleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: closeButton.trailingAnchor, constant: Constants.commonOffset),
            subtitleLabel.bottomAnchor.constraint(equalTo: icon.bottomAnchor),

            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: closeButton.trailingAnchor, constant: Constants.commonOffset),
            titleLabel.bottomAnchor.constraint(equalTo: subtitleLabel.topAnchor)
        ])
    }
    
    @objc private func didTapedCloseButton() {
        delegate?.didTapCloseButton()
    }
}
