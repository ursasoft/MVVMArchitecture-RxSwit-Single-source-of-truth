import UIKit

extension UITextField {
    // MARK: - INITIALIZERS

    convenience init(placeholder: String?, rightViewImage: UIImage? = nil) {
        self.init(frame: .zero)
        self.placeholder = placeholder
        borderStyle = .roundedRect

        if rightViewImage != nil {
            let rightImageView = UIImageView(image: rightViewImage)
            setRightView(rightImageView, padding: 10)
            rightViewMode = .always
        }
    }

    func setRightView(_ view: UIView, padding: CGFloat) {
        view.translatesAutoresizingMaskIntoConstraints = true

        let outerView = UIView()
        outerView.translatesAutoresizingMaskIntoConstraints = false
        outerView.addSubview(view)

        outerView.frame = CGRect(
            origin: .zero,
            size: CGSize(
                width: view.frame.size.width + padding,
                height: view.frame.size.height + padding
            )
        )

        view.center = CGPoint(
            x: outerView.bounds.size.width / 2,
            y: outerView.bounds.size.height / 2
        )

        rightView = outerView
    }
}
