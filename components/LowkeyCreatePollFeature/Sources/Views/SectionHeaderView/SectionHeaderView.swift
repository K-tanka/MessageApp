import UIKit
import LowkeySharedResources

final class SectionHeaderView: UIView {
    private enum Constants {
        static let fontSize: CGFloat = 15
        static let textFont: UIFont = LowkeyFont.regular(size: fontSize)
        static let textColor: UIColor = LowkeyCreatePollFeatureAsset.lkDarkGray.color
        static let horizontalInset: CGFloat = 16
        static let verticalInset: CGFloat = 8
    }

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.textFont
        label.textColor = Constants.textColor
        return label
    }()

    private lazy var counterLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.textFont
        label.textColor = Constants.textColor
        return label
    }()

    private let viewModel: SectionHeaderViewModel

    init(viewModel: SectionHeaderViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        preconditionFailure("init(coder:) has not been implemented")
    }

    func setTitleLabel(_ text: String) {
        titleLabel.text = text
    }

    func setCounterLabelText(_ text: String) {
        counterLabel.text = text
    }

    private func setupLayout() {
        addSubview(titleLabel)
        addSubview(counterLabel)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constants.verticalInset),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.verticalInset),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.horizontalInset),

            counterLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constants.verticalInset),
            counterLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.verticalInset),
            counterLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.horizontalInset)
        ])
    }

    static func height() -> CGFloat {
        Constants.verticalInset * 2 + Constants.fontSize
    }
}
