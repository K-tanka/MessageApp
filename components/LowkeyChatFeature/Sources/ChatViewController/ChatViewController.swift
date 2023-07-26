import UIKit
import LowkeySharedUIComponents

final class ChatViewController: UIViewController {
    
    private enum Constants {
        static let commonOffset = 16.0
    }
    
    private let viewModel: ChatViewControllerModel
    private let inputFieldView: UIView
    
    private lazy var inputFieldViewBottomConstraint: NSLayoutConstraint = inputFieldView
        .bottomAnchor
        .constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    
    private lazy var headerView: ChatHeaderView = {
        let view = ChatHeaderViewImpl(delegate: viewModel)
        view.updateMembersInfo(membersNumber: 5, onlineNumber: 2)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.register(PollCell.self)
        tableView.register(TextMessageCell.self)
        tableView.delegate = self
        tableView.dataSource = self
//        tableView.rowHeight = UITableView.automaticDimension
//        tableView.estimatedRowHeight = 60
        return tableView
    }()

    init(viewModel: ChatViewControllerModel,
         inputField: UIView) {
        self.viewModel = viewModel
        self.inputFieldView = inputField
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        preconditionFailure("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupLayout() {
        view.addSubview(headerView)
        view.addSubview(inputFieldView)
        view.addSubview(tableView)
        inputFieldView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            inputFieldView.topAnchor.constraint(equalTo: tableView.bottomAnchor),
            inputFieldView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                    constant: Constants.commonOffset),
            inputFieldView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                     constant: -Constants.commonOffset),
            inputFieldViewBottomConstraint
        ])
    }

    private func setupUI() {
        setupLayout()
        addObservers()
        setupGesture()
    }

    func updateLayoutIfNeeded() {
        UIView.animate(withDuration: 0.1) {
            self.view.layoutIfNeeded()
        }
    }

    private func addObservers() {
        NotificationCenter.default
            .addObserver(self,
                         selector: #selector(keyboardWillShow(_:)),
                         name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default
            .addObserver(self,
                         selector: #selector(keyboardWillHide),
                         name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    private func updateInputFieldConstraints(_ value: CGFloat = .zero) {
        inputFieldViewBottomConstraint.constant = -value
        updateLayoutIfNeeded()
    }

    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func hideKeyboard() {
        view.endEditing(true)
    }

    // swiftlint:disable line_length
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        else {
            return
        }
        updateInputFieldConstraints(keyboardSize.height - view.safeAreaInsets.bottom)
    }
    // swiftlint:enable line_length

    @objc private func keyboardWillHide() {
        updateInputFieldConstraints()
    }
}


extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let rowType = viewModel.typeForRow(indexPath.row) else {
            assertionFailure()
            return UITableViewCell()
        }

        switch rowType {
        case .textMessage:
            return tableView.dequeueReusableCell(withIdentifier: TextMessageCell.reuseIdentifier,
                                                 for: indexPath)
        case .poll:
            return tableView.dequeueReusableCell(withIdentifier: PollCell.reuseIdentifier,
                                                           for: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        switch cell {
        case let cell as TextMessageCell:
            cell.configure(viewModel.modelForChatCell(at: indexPath.row) as? TextMessageCellModel)
        case let cell as PollCell:
            cell.configure(viewModel.modelForChatCell(at: indexPath.row) as? PollCellViewModel)
        default:
            assertionFailure()
        }
    }
    
    func insertRows(at indexPath: IndexPath) {
        tableView.performBatchUpdates({
            tableView.insertRows(at: [indexPath], with: .fade)
        })
        tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
}


extension ChatViewController: UITableViewDelegate {

}
