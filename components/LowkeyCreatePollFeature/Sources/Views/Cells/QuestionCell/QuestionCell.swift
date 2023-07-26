import UIKit
import LowkeySharedResources
import LowkeySharedUIComponents

final class QuestionCell: UITableViewCell, ReusableView {
    private enum Constants {
        static let textFont: UIFont = LowkeyFont.regular(size: 15)
        static let textViewHeight: CGFloat = 80
        static let horizontalInset: CGFloat = 16
        static let verticalInset: CGFloat = 8
        static let characterLimit = 140
        static let textViewBorderRadius: CGFloat = 5
    }

    private lazy var textView: DynamicTextView = {
        let textView = DynamicTextView(numberOfLines: .zero,
                                       font: Constants.textFont,
                                       characterLimit: Constants.characterLimit)
        textView.placeholderText = LowkeyCreatePollFeatureStrings.Create.Poll.Question.placeholder
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.layer.cornerRadius = Constants.textViewBorderRadius
        textView.clipsToBounds = true
        return textView
    }()

    private var viewModel: QuestionCellViewModel?

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

    func configure(_ cellModel: QuestionCellViewModel) {
        viewModel = cellModel
        textView.dynamicTextViewDelegate = viewModel
    }

    func getQuestionText() -> String {
        textView.getText()
    }

    private func setupLayout() {
        contentView.addSubview(textView)

        NSLayoutConstraint.activate([
            textView.heightAnchor.constraint(equalToConstant: Constants.textViewHeight),
            textView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.verticalInset),
            textView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.horizontalInset),
            textView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                               constant: -Constants.horizontalInset),
            textView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.verticalInset)
        ])
    }
}
