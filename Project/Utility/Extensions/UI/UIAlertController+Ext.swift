import UIKit

extension UIAlertController {
    static func alert(title: String? = nil,
                      message: String? = nil,
                      actions: [UIAlertAction] = [],
                      preferredStyle: UIAlertController.Style = .alert) -> UIAlertController {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        for action in actions {
            alertVC.addAction(action)
        }
        return alertVC
    }
}
