import UIKit
import LowkeySharedUIComponents
import LowkeySharedResources

final class InputFieldView: UIView {
    private enum Constants {
        static let fontSize: CGFloat = 15
        static let textFont: UIFont = LowkeyFont.regular(size: fontSize)
        static let textColor: UIColor = LowkeyInputFieldFeatureAsset.lkDarkGray.color
        static let horizontalInset: CGFloat = 16
        static let verticalInset: CGFloat = 8
        static let numberOfLineLimit = 5
        static let textViewBorderRadius: CGFloat = 5
        static let buttonSideSize: CGFloat = 40
        static let sendButtonImage = LowkeyInputFieldFeatureAsset.paperplane.image
        static let pollButtonImage = LowkeyInputFieldFeatureAsset.questionmarkBubble.image
    }

    private lazy var textView: DynamicTextView = {
        let textView = DynamicTextView(numberOfLines: Constants.numberOfLineLimit,
                                       font: Constants.textFont)
        textView.backgroundColor = LowkeyInputFieldFeatureAsset.lkBlack2.color
        textView.placeholderText = LowkeyInputFieldFeatureStrings.placeholder
        textView.dynamicTextViewDelegate = viewModel
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.layer.cornerRadius = Constants.textViewBorderRadius
        textView.clipsToBounds = true
        return textView
    }()

    private lazy var leftButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(Constants.pollButtonImage, for: .normal)
        button.addTarget(self, action: #selector(leftButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var rightButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(Constants.sendButtonImage, for: .normal)
        button.addTarget(self, action: #selector(rightButtonTapped), for: .touchUpInside)
        return button
    }()

    private let viewModel: InputFieldViewModel

    init(viewModel: InputFieldViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        preconditionFailure("init(coder:) has not been implemented")
    }

    func clearTextView() {
        textView.text = ""
    }

    @objc private func leftButtonTapped() {
        viewModel.didTapOnPollButton()
    }

    @objc private func rightButtonTapped() {
        viewModel.didTapOnSendMessageButton(textView.getText())
    }

    private func setupLayout() {
        addSubview(leftButton)
        addSubview(rightButton)
        addSubview(textView)

        NSLayoutConstraint.activate([
            leftButton.heightAnchor.constraint(equalToConstant: Constants.buttonSideSize),
            leftButton.widthAnchor.constraint(equalToConstant: Constants.buttonSideSize),
            leftButton.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                constant: Constants.horizontalInset),
            leftButton.bottomAnchor.constraint(equalTo: bottomAnchor),

            rightButton.heightAnchor.constraint(equalToConstant: Constants.buttonSideSize),
            rightButton.widthAnchor.constraint(equalToConstant: Constants.buttonSideSize),
            rightButton.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                  constant: -Constants.horizontalInset),
            rightButton.bottomAnchor.constraint(equalTo: bottomAnchor),

            textView.topAnchor.constraint(equalTo: topAnchor,
                                          constant: Constants.verticalInset),
            textView.bottomAnchor.constraint(equalTo: bottomAnchor,
                                             constant: -Constants.verticalInset),
            textView.leadingAnchor.constraint(equalTo: leftButton.trailingAnchor,
                                              constant: Constants.horizontalInset),
            textView.trailingAnchor.constraint(equalTo: rightButton.leadingAnchor,
                                               constant: -Constants.horizontalInset)
        ])
    }
}
