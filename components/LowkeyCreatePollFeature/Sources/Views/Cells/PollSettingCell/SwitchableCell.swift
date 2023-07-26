import UIKit
import LowkeySharedResources
import LowkeySharedUIComponents

final class SwitchableCell: UITableViewCell, ReusableView {
    private enum Constants {
        static let commonOffset = 16.0
        static let textColor = UIColor.white
        static let textFont = LowkeyFont.regular(size: 15)
        static let switchBorderWidth = 1.0
        static let switchBorderColor = LowkeyCreatePollFeatureAsset.lkDarkGray.color.cgColor
        static let switchControlVerticalInset: CGFloat = 15
        static let imageSideSize: CGFloat = 30
    }

    private lazy var iconView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.textFont
        label.textColor = Constants.textColor
        return label
    }()

    private lazy var switchControl: UISwitch = {
        let switchControl = UISwitch()
        switchControl.onTintColor = .blue
        switchControl.layer.borderColor = Constants.switchBorderColor
        switchControl.layer.borderWidth = Constants.switchBorderWidth
        switchControl.layer.cornerRadius = Constants.commonOffset
        switchControl.thumbTintColor = switchControl.isOn ? .white : .gray
        switchControl.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)
        switchControl.translatesAutoresizingMaskIntoConstraints = false
        return switchControl
    }()

    private var viewModel: SwitchableCellModel?

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

    func configure(_ viewModel: SwitchableCellModel?) {
        guard let viewModel = viewModel else {
            assertionFailure()
            return
        }
        switchControl.isOn = viewModel.isOn
        setImageForCellType(viewModel.type)
        titleLabel.text = viewModel.title
        self.viewModel = viewModel
    }

    private func setupLayout() {
        contentView.addSubview(iconView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(switchControl)

        NSLayoutConstraint.activate([
            switchControl.topAnchor.constraint(equalTo: contentView.topAnchor,
                                               constant: Constants.switchControlVerticalInset),
            switchControl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                               constant: -Constants.switchControlVerticalInset),
            switchControl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                    constant: -Constants.commonOffset),
            switchControl.leadingAnchor.constraint(greaterThanOrEqualTo: titleLabel.trailingAnchor,
                                                   constant: Constants.commonOffset),

            iconView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                              constant: Constants.commonOffset),
            iconView.widthAnchor.constraint(equalToConstant: Constants.imageSideSize),
            iconView.heightAnchor.constraint(equalToConstant: Constants.imageSideSize),
            iconView.centerYAnchor.constraint(equalTo: switchControl.centerYAnchor),

            titleLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor,
                                                constant: Constants.commonOffset),
            titleLabel.centerYAnchor.constraint(equalTo: iconView.centerYAnchor)
        ])
    }

    private func setImageForCellType(_ type: PollSettingCellType) {
        switch type {
        case .anonymous:
            iconView.image = LowkeyCreatePollFeatureAsset.rectangleAndPencilAndEllipsis.image
        case .addMoreOptions:
            iconView.image = LowkeyCreatePollFeatureAsset.pencilTipCropCircleBadgePlus.image
        }
    }

    @objc private func switchValueChanged() {
        switchControl.layer.borderWidth = switchControl.isOn ? .zero : Constants.switchBorderWidth
        switchControl.thumbTintColor = switchControl.isOn ? .white : .gray
        viewModel?.isOn = switchControl.isOn
    }
}
