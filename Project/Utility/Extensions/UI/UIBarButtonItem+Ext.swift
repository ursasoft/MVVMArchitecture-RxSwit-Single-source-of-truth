import RxCocoa
import RxSwift
import UIKit

extension UIBarButtonItem {
    var tap: Observable<ControlEvent<Void>.Element> {
        rx.tap.throttle(.seconds(1), scheduler: MainScheduler.instance)
    }
}
