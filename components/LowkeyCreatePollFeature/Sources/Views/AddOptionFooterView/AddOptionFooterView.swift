import UIKit
import LowkeySharedResources

protocol AddOptionFooterViewDelegate: AnyObject {
    func addOptionButtonTapped()
}

final class AddOptionFooterView: UIView {
    private enum Constants {
        static let fontSize: CGFloat = 15
        static let commonOffset = 16.0
        static let buttonOffset = 15.0
        static let cornerRadius = 15.0
        static let textColor = LowkeyCreatePollFeatureAsset.lkBlue.color
        static let selectedColor = textColor.withAlphaComponent(0.2)
        static let backgroundColor = LowkeyCreatePollFeatureAsset.lkBlack1.color
        static let textFont = LowkeyFont.regular(size: fontSize)
    }

    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.backgroundColor
        view.layer.cornerRadius = Constants.cornerRadius
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var addOptionButton: UIButton = {
        let button = UIButton()
        let title = LowkeyCreatePollFeatureStrings.Create.Poll.Question.footer
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = Constants.textFont
        button.setTitleColor(Constants.textColor, for: .normal)
        button.setTitleColor(Constants.selectedColor, for: .highlighted)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()

    weak var delegate: AddOptionFooterViewDelegate?

    init(delegate: AddOptionFooterViewDelegate) {
        self.delegate = delegate
        super.init(frame: .zero)
        setupLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        preconditionFailure("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        addSubview(containerView)
        containerView.addSubview(addOptionButton)

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor,
                                               constant: Constants.commonOffset),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                   constant: Constants.commonOffset),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                    constant: -Constants.commonOffset),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor,
                                                  constant: -Constants.commonOffset),

            addOptionButton.topAnchor.constraint(equalTo: containerView.topAnchor,
                                                 constant: Constants.buttonOffset),
            addOptionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,
                                                     constant: Constants.buttonOffset),
            addOptionButton.trailingAnchor.constraint(lessThanOrEqualTo: containerView.trailingAnchor,
                                                      constant: -Constants.buttonOffset),
            addOptionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor,
                                                    constant: -Constants.buttonOffset)
        ])
    }

    @objc private func buttonTapped() {
        delegate?.addOptionButtonTapped()
    }

    static func height() -> CGFloat {
        (Constants.commonOffset + Constants.buttonOffset) * 2 + Constants.fontSize
    }
}
