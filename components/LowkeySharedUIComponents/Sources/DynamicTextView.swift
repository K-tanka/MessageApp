import UIKit

public protocol DynamicTextViewDelegate: AnyObject {
    func numberEnteredСharacters(_ number: Int)
    func didBeginEditing()
    func didEndEditing()
}

public final class DynamicTextView: UITextView {

    private enum Constants {
        static let textContainerVerticalInset: CGFloat = 4
    }

    private lazy var heightConstraint = heightAnchor.constraint(equalToConstant: .zero)
    private var maxHeight: CGFloat = .zero
    private let characterLimit: Int?

    public var placeholderText: String? {
        didSet {
            textColor = UIColor.lightGray
            text = placeholderText
        }
    }

    public weak var dynamicTextViewDelegate: DynamicTextViewDelegate?

    public init(numberOfLines: Int,
                font: UIFont,
                characterLimit: Int? = nil) {
        self.characterLimit = characterLimit
        super.init(frame: .zero, textContainer: nil)
        delegate = self
        setupUI(numberOfLines: numberOfLines, font: font)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        preconditionFailure("init(coder:) has not been implemented")
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        adjustTextHeight()
    }

    private func setupUI(numberOfLines: Int, font: UIFont) {
        self.font = font
        textContainerInset = UIEdgeInsets(top: Constants.textContainerVerticalInset,
                                          left: Constants.textContainerVerticalInset,
                                          bottom: Constants.textContainerVerticalInset,
                                          right: Constants.textContainerVerticalInset)
        calculateMaxHeight(numberOfLines: numberOfLines, font: font)
        setupConstraints(numberOfLines: numberOfLines)
    }

    private func calculateMaxHeight(numberOfLines: Int, font: UIFont) {
        guard numberOfLines != .zero else { return }
        let textInset = textContainerInset.top + textContainerInset.bottom
        maxHeight = font.lineHeight * CGFloat(Float(numberOfLines)) + textInset
        adjustTextHeight()
    }

    private func setupConstraints(numberOfLines: Int) {
        guard numberOfLines != .zero else { return }
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([heightConstraint])
    }

    private func adjustTextHeight() {
        heightConstraint.constant = contentSize.height >= maxHeight ? maxHeight : contentSize.height
        layoutIfNeeded()
    }
}

extension DynamicTextView: UITextViewDelegate {
    public func textViewDidChange(_ textView: UITextView) {
        adjustTextHeight()
    }

    public func textView(_ textView: UITextView,
                         shouldChangeTextIn range: NSRange,
                         replacementText text: String) -> Bool {
        guard let characterLimit = characterLimit else {
           return true
        }

        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else {
            return false
        }

        let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
        let numberEnteredCharacters = updatedText.count

        if numberEnteredCharacters <= characterLimit {
            dynamicTextViewDelegate?.numberEnteredСharacters(numberEnteredCharacters)
            return true
        } else {
            return false
        }
    }

    public func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.white
        }
        dynamicTextViewDelegate?.didBeginEditing()
    }

    public func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = placeholderText
            textView.textColor = UIColor.lightGray
        }
        dynamicTextViewDelegate?.didEndEditing()
    }

    public func getText() -> String {
        if textColor == UIColor.lightGray {
            return ""
        }
        return text
    }
}
