import UIKit

// MARK: - EXTENSION DEFINITION

extension UILabel {
    convenience init(text: String? = nil,
                     font: UIFont = .systemFont(ofSize: 16),
                     textColor: UIColor? = .black,
                     textAlignment: NSTextAlignment = .left,
                     numberOfLines: Int = 1,
                     minimumScaleFactor: CGFloat = 0.0) {
        self.init()
        self.text = text
        self.textAlignment = textAlignment
        self.numberOfLines = numberOfLines
        self.textColor = textColor
        self.font = font
        if minimumScaleFactor > 0 {
            adjustsFontSizeToFitWidth = true
            self.minimumScaleFactor = minimumScaleFactor
        }
    }
}
