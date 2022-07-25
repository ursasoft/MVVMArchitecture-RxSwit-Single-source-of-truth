import RxCocoa
import RxSwift
import UIKit

class BaseTableViewCell: UITableViewCell {
    // MARK: - PUBLIC PROPERTIES

    public var disposeBag = DisposeBag()

    // MARK: - LIFE TIME METHODS

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
}
