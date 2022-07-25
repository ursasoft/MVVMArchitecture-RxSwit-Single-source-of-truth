import RxCocoa
import RxSwift
import UIKit

class BaseViewModel {
    // MARK: - PUBLIC PROPERTIES

    let disposeBag = DisposeBag()
    var toastState = BehaviorRelay<ToastState>(value: .none(action: nil))
}
