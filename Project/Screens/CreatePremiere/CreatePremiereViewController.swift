import Domain
import RxCocoa
import RxSwift
import UIKit

class CreatePremiereViewController: BaseViewController {
    // MARK: - PRIVATE PROPERTIES

    private let rootView: CreatePremiereView
    private let viewModel: CreatePremiereViewModel!

    // MARK: - INITIALIZERS

    init(rootView: CreatePremiereView, viewModel: CreatePremiereViewModel) {
        self.rootView = rootView
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    // MARK: - LIFE TIME METHODS

    override func loadView() {
        super.loadView()
        createView(view: rootView)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bindToastState(viewModel)

        if let rightBarButtonItem = navigationItem.rightBarButtonItem {
            rightBarButtonItem.tap.bind { [weak self] in
                guard let self = self else { return }
                self.viewModel.save(input: self.rootView.input)
            }.disposed(by: viewModel.disposeBag)
        }
    }
}
