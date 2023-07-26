import UIKit
import LowkeySharedResources
import LowkeySharedUIComponents

final class PollCell: UITableViewCell, ReusableView {
    private enum Constants {
        static let commonOffset = 16.0
        static let textColor = UIColor.white
        static let pollNameFont = UIFont.systemFont(ofSize: 11)
        static let ownerNameFont = UIFont.systemFont(ofSize: 13)
        static let questionFont = UIFont.systemFont(ofSize: 15)
        static let spacing = 8.0
        static let cornerRadius = 20.0
        static let gradientColors = [UIColor.systemPink.cgColor,
                                     LowkeyChatFeatureAsset.violet2.color.cgColor,
                                     UIColor.black.withAlphaComponent(0.9).cgColor]
        static let ownerIconSize = CGSize(width: 45.0, height: 45.0)
        static let votesNumberViewSize = CGSize(width: 60.0, height: 60.0)
        static let variantButtonBackgroundColor = LowkeyChatFeatureAsset.violet3.color
    }

    private lazy var gradientLayer = overlayGradientLayer()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = Constants.cornerRadius
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var ownerIconView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.layer.cornerRadius = Constants.ownerIconSize.height / 2
        view.layer.masksToBounds = true
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var pollNameLabel: UILabel = {
        let label = UILabel()
        label.text = LowkeyChatFeatureStrings.Chat.Public.Poll.title
        label.font = Constants.pollNameFont
        label.textColor = Constants.textColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var ownerNameLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.ownerNameFont
        label.textColor = Constants.textColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var questionLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.questionFont
        label.textColor = Constants.textColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var votesNumberView: VotesNumberView = {
        let view = VotesNumberViewImpl()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var optionsContainerView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = Constants.spacing
        stackView.backgroundColor = .clear
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private var cellModel: PollCellViewModel?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUIElements()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        preconditionFailure("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
    
    func configure(_ cellModel: PollCellViewModel?) {
        self.cellModel = cellModel
        setupValues()
        invalidateIntrinsicContentSize()
    }
    
    private func setupValues() {
        guard let cellModel = cellModel else { return }
        ownerNameLabel.text = cellModel.ownerName
        ownerIconView.image = cellModel.ownerIcon
        questionLabel.text = cellModel.question
        votesNumberView.votesNumber = cellModel.votesNumber
        setupOptionsContainerView(cellModel.options)
    }

    // swiftlint:disable function_body_length
    private func setupUIElements() {
        contentView.addSubview(containerView)
        containerView.addSubview(ownerIconView)
        containerView.addSubview(pollNameLabel)
        containerView.addSubview(ownerNameLabel)
        containerView.addSubview(votesNumberView)
        containerView.addSubview(questionLabel)
        containerView.addSubview(optionsContainerView)

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor,
                                               constant: Constants.commonOffset / 2),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                   constant: Constants.commonOffset),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                    constant: -Constants.commonOffset),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                                  constant: -Constants.commonOffset / 2),
            
            ownerIconView.heightAnchor.constraint(equalToConstant: Constants.ownerIconSize.height),
            ownerIconView.widthAnchor.constraint(equalToConstant: Constants.ownerIconSize.width),
            ownerIconView.topAnchor.constraint(equalTo: containerView.topAnchor,
                                               constant: Constants.commonOffset),
            ownerIconView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,
                                                   constant: Constants.commonOffset),

            pollNameLabel.topAnchor.constraint(equalTo: ownerIconView.topAnchor),
            pollNameLabel.leadingAnchor.constraint(equalTo: ownerIconView.trailingAnchor,
                                                   constant: Constants.commonOffset),

            ownerNameLabel.topAnchor.constraint(equalTo: pollNameLabel.bottomAnchor,
                                                constant: Constants.commonOffset / 2),
            ownerNameLabel.leadingAnchor.constraint(equalTo: pollNameLabel.leadingAnchor),
            ownerNameLabel.trailingAnchor.constraint(equalTo: pollNameLabel.trailingAnchor),

            votesNumberView.heightAnchor.constraint(equalToConstant: Constants.votesNumberViewSize.height),
            votesNumberView.widthAnchor.constraint(equalToConstant: Constants.votesNumberViewSize.width),
            votesNumberView.topAnchor.constraint(equalTo: containerView.topAnchor,
                                                 constant: Constants.commonOffset / 2),
            votesNumberView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,
                                                      constant: -Constants.commonOffset),
            votesNumberView.leadingAnchor.constraint(greaterThanOrEqualTo: pollNameLabel.trailingAnchor,
                                                     constant: Constants.commonOffset),

            questionLabel.topAnchor.constraint(equalTo: votesNumberView.bottomAnchor,
                                               constant: Constants.commonOffset),
            questionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,
                                                   constant: Constants.commonOffset),
            questionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,
                                                    constant: -Constants.commonOffset),

            optionsContainerView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor,
                                                       constant: Constants.commonOffset),
            optionsContainerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,
                                                           constant: Constants.commonOffset),
            optionsContainerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,
                                                            constant: -Constants.commonOffset),
            optionsContainerView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor,
                                                          constant: -Constants.commonOffset)
        ])
    }
    // swiftlint:enabled function_body_length
    private func overlayGradientLayer() -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.locations = [0.0, 0.25, 1]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.type = .axial
        gradientLayer.colors = Constants.gradientColors
        containerView.layer.insertSublayer(gradientLayer, at: .zero)
        return gradientLayer
    }

    private func setupOptionsContainerView(_ variants: [String]) {
        optionsContainerView.subviews.forEach { $0.removeFromSuperview() }
        variants.forEach {
            let button = createOptionButton($0)
            optionsContainerView.addArrangedSubview(button)
        }
    }

    private func createOptionButton(_ text: String) -> UIButton {
        let button = UIButton()
        button.setTitle(text, for: .normal)
        button.tintColor = Constants.textColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = Constants.cornerRadius / 2
        button.layer.masksToBounds = true
        button.contentHorizontalAlignment = .left
        button.backgroundColor = Constants.variantButtonBackgroundColor
        button.addTarget(self, action: #selector(didTapedVariantButton), for: .touchUpInside)
        if #available(iOS 15.0, *) {
            var configuration = UIButton.Configuration.plain()
            configuration.contentInsets.leading = Constants.commonOffset
            button.configuration = configuration
        } else {
            button.titleEdgeInsets.left = Constants.commonOffset
        }
        return button
    }

    @objc private func didTapedVariantButton() {
        guard let cellModel = cellModel else { return }
        cellModel.updateVotesNumber()
        votesNumberView.votesNumber = cellModel.votesNumber
    }
}
