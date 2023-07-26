import UIKit
import LowkeySharedResources

protocol VotesNumberView: UIView {
    var votesNumber: Int { get set }
}

final class VotesNumberViewImpl: UIView, VotesNumberView {
    private enum Constants {
        static let commonOffset = 16.0
        static let backgroundColor = UIColor.systemPink
        static let titleTextColor = UIColor.white
        static let titleTextFont = LowkeyFont.regular(size: 13)
        static let titleNumberOfLines = 2
    }

    var votesNumber: Int = 0 {
        didSet {
            titleLabel.text = LowkeyChatFeatureStrings.Chat.Vote.Result.VotesNumber.format(votesNumber)
        }
    }

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.titleTextFont
        label.textColor = Constants.titleTextColor
        label.text = LowkeyChatFeatureStrings.Chat.Header.title
        label.numberOfLines = Constants.titleNumberOfLines
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    init() {
        super.init(frame: .zero)
        backgroundColor = Constants.backgroundColor
        setupUIElements()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        preconditionFailure("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setCornerRadius()
    }

    private func setCornerRadius() {
        layer.cornerRadius = frame.height / 2
        clipsToBounds = true
    }

    private func setupUIElements() {
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
