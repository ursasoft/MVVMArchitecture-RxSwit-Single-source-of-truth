import UIKit

// MARK: - EXTENSION DEFINITION

extension UIView {
    convenience init(backgroundColor: UIColor?) {
        self.init()
        self.backgroundColor = backgroundColor
    }

    func addSubviews(_ views: [UIView]) {
        _ = views.map {
            addSubview($0)
        }
    }
}
