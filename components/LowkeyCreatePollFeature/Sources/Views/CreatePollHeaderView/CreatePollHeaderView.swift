import UIKit
import LowkeySharedResources

protocol CreatePollHeaderViewDelegate: AnyObject {
    func didTapCloseButton()
    func didTapDoneButton()
}

final class CreatePollHeaderView: UIView {
    private enum Constants {
        static let commonOffset = 16.0
        static let verticalOffset: CGFloat = 16
        static let textColor = UIColor.white
        static let createButtonColor = UIColor.gray
        static let textFont = LowkeyFont.regular(size: 15)
    }

    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(LowkeySharedResourcesAsset.xmark.image, for: .normal)
        button.tintColor = Constants.textColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapedCloseButton), for: .touchUpInside)
        return button
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.textFont
        label.textColor = Constants.textColor
        label.text = LowkeyCreatePollFeatureStrings.Create.Poll.Header.title
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var createButton: UIButton = {
        let button = UIButton()
        button.setTitle(LowkeyCreatePollFeatureStrings.Create.Poll.Header.Button.title, for: .normal)
        button.setTitleColor(Constants.createButtonColor, for: .normal)
        button.titleLabel?.font = Constants.textFont
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapedCreateButton), for: .touchUpInside)
        return button
    }()

    weak var delegate: CreatePollHeaderViewDelegate?

    init(delegate: CreatePollHeaderViewDelegate) {
        self.delegate = delegate
        super.init(frame: .zero)
        backgroundColor = .systemBackground
        setupLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        preconditionFailure("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        addSubview(closeButton)
        addSubview(titleLabel)
        addSubview(createButton)

        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: topAnchor,
                                             constant: Constants.verticalOffset),
            closeButton.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                 constant: Constants.commonOffset),
            closeButton.bottomAnchor.constraint(equalTo: bottomAnchor,
                                                constant: -Constants.verticalOffset),

            titleLabel.centerYAnchor.constraint(equalTo: closeButton.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: closeButton.trailingAnchor,
                                                constant: Constants.commonOffset),

            createButton.centerYAnchor.constraint(equalTo: closeButton.centerYAnchor),
            createButton.leadingAnchor.constraint(greaterThanOrEqualTo: titleLabel.trailingAnchor,
                                                  constant: Constants.commonOffset),
            createButton.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                   constant: -Constants.commonOffset)
        ])
    }

    @objc private func didTapedCloseButton() {
        delegate?.didTapCloseButton()
    }

    @objc private func didTapedCreateButton() {
        delegate?.didTapDoneButton()
    }
}
