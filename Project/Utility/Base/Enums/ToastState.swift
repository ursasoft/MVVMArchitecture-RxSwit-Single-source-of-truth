import Foundation

typealias Action = (() -> Void)?

enum ToastState {
    case none(action: Action)
    case indicator
    case error(text: String)
}
