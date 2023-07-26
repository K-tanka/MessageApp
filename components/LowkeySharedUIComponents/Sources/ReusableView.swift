import UIKit

public protocol ReusableView {
    static var reuseIdentifier: String { get }
}

public extension ReusableView where Self: UITableViewCell {
    static var reuseIdentifier: String {
        return NSStringFromClass(self)
    }
}

public extension ReusableView where Self: UICollectionViewCell {
    static var reuseIdentifier: String {
        return NSStringFromClass(self)
    }
}

public extension ReusableView where Self: UITableViewHeaderFooterView {
    static var reuseIdentifier: String {
        return NSStringFromClass(self)
    }
}

public extension ReusableView where Self: UICollectionReusableView {
    static var reuseIdentifier: String {
        return NSStringFromClass(self)
    }
}
