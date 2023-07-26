import UIKit

extension UITableView {
    public func register<C: UITableViewCell & ReusableView>(_ cellClass: C.Type) {
        register(cellClass, forCellReuseIdentifier: cellClass.reuseIdentifier)
    }

    public func dequeue<Cell: UITableViewCell & ReusableView>(_ cellType: Cell.Type) -> Cell? {
        return dequeueReusableCell(withIdentifier: cellType.reuseIdentifier)
            .flatMap { $0 as? Cell }
    }

    // swiftlint:disable line_length
    public func dequeue<Cell: UITableViewCell & ReusableView>(_ cellType: Cell.Type, for indexPath: IndexPath) -> Cell? {
        return dequeueReusableCell(withIdentifier: cellType.reuseIdentifier, for: indexPath) as? Cell
    }
    // swiftlint:enabled line_length
}
