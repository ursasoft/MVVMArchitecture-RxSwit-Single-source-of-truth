import RxSwift
import SnapKit
import Toast_Swift
import UIKit

class BaseViewController: UIViewController {
    // MARK: - PUBLIC PROPERTIES

    let disposeBag = DisposeBag()

    // MARK: - INITIALIZERS

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        edgesForExtendedLayout = []
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - PUBLIC METHODS

    func createView(view: UIView) {
        self.view.backgroundColor = .white
        self.view.addSubview(view)
        view.snp.makeConstraints { [unowned self] in
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    func bindToastState(_ viewModel: BaseViewModel) {
        viewModel.toastState
            .skip(1)
            .bind { [weak self] state in

                DispatchQueue.main.async {
                    switch state {
                    case let .none(action):
                        self?.view.hideToastActivity()
                        self?.view.hideAllToasts()
                        action?()
                    case .indicator:
                        self?.view.makeToastActivity(.center)
                    case let .error(text):
                        self?.view.hideToastActivity()
                        self?.view.makeToast(text, duration: 4.0, position: .center)
                    }
                }

            }.disposed(by: viewModel.disposeBag)
    }

    deinit {
        print("\(NSStringFromClass(classForCoder)) deinit!")
    }
}
