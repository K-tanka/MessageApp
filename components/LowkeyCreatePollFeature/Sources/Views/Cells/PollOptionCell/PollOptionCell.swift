import UIKit
import LowkeySharedResources
import LowkeySharedUIComponents

protocol PollOptionCellDelegate: AnyObject {
    func deleteOptionCell(_ cell: PollOptionCell)
    func didBeginEditingCell(_ cell: UITableViewCell)
    func didEndEditingCell()
}

final class PollOptionCell: UITableViewCell, ReusableView {
    private enum Constants {
        static let textFont: UIFont = LowkeyFont.regular(size: 15)
        static let textViewHeight: CGFloat = 55
        static let commonOffset = 16.0
        static let characterLimit = 60
        static let textViewBorderRadius: CGFloat = 5
        static let backgroundColor = LowkeyCreatePollFeatureAsset.lkBlack1.color
        static let deleteButtonBackgroundColor = LowkeyCreatePollFeatureAsset.lkBlack2.color
        static let cornerRadius: CGFloat = 10.0
        static let deleteButtonWidth: CGFloat = 60.0
        static let containerViewOffset = 3.0
    }

    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.backgroundColor
        view.layer.cornerRadius = Constants.cornerRadius
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var textView: DynamicTextView = {
        let textView = DynamicTextView(numberOfLines: .zero,
                                       font: Constants.textFont,
                                       characterLimit: Constants.characterLimit)
        textView.dynamicTextViewDelegate = self
        textView.backgroundColor = .clear
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.layer.cornerRadius = Constants.textViewBorderRadius
        textView.clipsToBounds = true
        return textView
    }()

    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(LowkeySharedResourcesAsset.xmark.image, for: .normal)
        button.tintColor = .white
        button.backgroundColor = Constants.deleteButtonBackgroundColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapedDeleteButton), for: .touchUpInside)
        return button
    }()

    private var viewModel: PollOptionCellViewModel?
    private weak var delegate: PollOptionCellDelegate?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        setupLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        preconditionFailure("init(coder:) has not been implemented")
    }

    func configure(_ viewModel: PollOptionCellViewModel?,
                   delegate: PollOptionCellDelegate) {
        self.viewModel = viewModel
        self.delegate = delegate
    }

    func getOptionText() -> String {
        textView.text
    }

    @objc private func didTapedDeleteButton() {
        textView.text = ""
        delegate?.deleteOptionCell(self)
    }

    private func setupLayout() {
        contentView.addSubview(containerView)
        containerView.addSubview(textView)
        containerView.addSubview(deleteButton)

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor,
                                               constant: Constants.containerViewOffset),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                   constant: Constants.commonOffset),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                    constant: -Constants.commonOffset),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                                  constant: -Constants.containerViewOffset),

            textView.topAnchor.constraint(equalTo: containerView.topAnchor),
            textView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            textView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            textView.heightAnchor.constraint(equalToConstant: Constants.textViewHeight),

            deleteButton.widthAnchor.constraint(equalToConstant: Constants.deleteButtonWidth),
            deleteButton.topAnchor.constraint(equalTo: containerView.topAnchor),
            deleteButton.leadingAnchor.constraint(equalTo: textView.trailingAnchor),
            deleteButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            deleteButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
}

extension PollOptionCell: DynamicTextViewDelegate {
    func numberEnteredСharacters(_ number: Int) {}

    func didBeginEditing() {
        delegate?.didBeginEditingCell(self)
    }

    func didEndEditing() {
        delegate?.didEndEditingCell()
    }
}
