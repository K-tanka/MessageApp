import UIKit
import LowkeySharedUIComponents

final class CreatePollViewController: UIViewController {

    private let viewModel: CreatePollViewControllerModel

    private lazy var headerView: CreatePollHeaderView = {
        let view = CreatePollHeaderView(delegate: viewModel)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private var activeCellFrame: CGRect?

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.register(QuestionCell.self)
        tableView.register(SwitchableCell.self)
        tableView.register(PollOptionCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

    init(viewModel: CreatePollViewControllerModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        preconditionFailure("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        subscribeOnKeyboardsNotifications()
        setupGesture()
    }

    private func setupLayout() {
        view.addSubview(headerView)
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),

            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    private func subscribeOnKeyboardsNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc private func keyboardWillShow(notification: Notification) {
        // swiftlint:disable line_length
        guard
            let activeCellFrame = activeCellFrame,
            let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        else {
            return
        }
        // swiftlint:enable line_length
        tableView.contentInset = UIEdgeInsets(top: .zero,
                                              left: .zero,
                                              bottom: keyboardSize.height,
                                              right: .zero)
        tableView.scrollRectToVisible(activeCellFrame,
                                      animated: true)
    }

    @objc private func keyboardWillHide(notification: Notification) {
        tableView.contentInset = .zero
    }

    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
}

extension CreatePollViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let model = viewModel.viewModelForHeader(at: section) else {
            return nil
        }
        let view = SectionHeaderView(viewModel: model)
        model.view = view
        model.setupInitialState()
        return view
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard viewModel.isNeedCreateFooterFor(section: section) else {
            return nil
        }
        return AddOptionFooterView(delegate: viewModel)
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard viewModel.viewModelForHeader(at: section) != nil else {
            return .leastNormalMagnitude
        }
        return SectionHeaderView.height()
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        guard viewModel.isNeedCreateFooterFor(section: section) else {
            return  .leastNormalMagnitude
        }
        return AddOptionFooterView.height()
    }
}

extension CreatePollViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection(section: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let sectionType = viewModel.typeForSection(section: indexPath.section) else {
            assertionFailure()
            return UITableViewCell()
        }

        switch sectionType {
        case .question:
            return tableView.dequeueReusableCell(withIdentifier: QuestionCell.reuseIdentifier,
                                                 for: indexPath)
        case .option:
            return tableView.dequeueReusableCell(withIdentifier: PollOptionCell.reuseIdentifier,
                                                 for: indexPath)
        case .settings:
            return tableView.dequeueReusableCell(withIdentifier: SwitchableCell.reuseIdentifier,
                                                 for: indexPath)
        }
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        switch cell {
        case let cell as QuestionCell:
            viewModel.questionCellViewModel.view = cell
            cell.configure(viewModel.questionCellViewModel)
        case let cell as SwitchableCell:
            cell.configure(viewModel.modelForSettingSection(at: indexPath.row))
        case let cell as PollOptionCell:
            let model = viewModel.modelForOptionsSection(at: indexPath.row)
            model?.view = cell
            cell.configure(model, delegate: self)
        default:
            assertionFailure()
        }
    }

    func insertRows(at indexPath: IndexPath) {
        tableView.performBatchUpdates({
            tableView.insertRows(at: [indexPath], with: .fade)
        })
    }

    func deleteRows(at indexPath: IndexPath) {
        tableView.performBatchUpdates({
            tableView.deleteRows(at: [indexPath], with: .fade)
        })
    }
}

extension CreatePollViewController: PollOptionCellDelegate {
    func deleteOptionCell(_ cell: PollOptionCell) {
        guard let indexPath = tableView.indexPath(for: cell) else {
            return
        }
        viewModel.removeOption(at: indexPath)
    }

    func didBeginEditingCell(_ cell: UITableViewCell) {
        activeCellFrame = cell.frame
    }

    func didEndEditingCell() {
        tableView.contentInset = .zero
        activeCellFrame = nil
    }
}
