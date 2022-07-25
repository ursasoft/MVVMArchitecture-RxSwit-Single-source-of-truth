import Domain
import RxCocoa
import RxSwift
import UIKit

class PremieresViewController: BaseViewController {
    // MARK: - PRIVATE PROPERTIES

    private let rootView: PremieresView
    private let viewModel: PremieresViewModel

    // MARK: - INITIALIZERS

    init(rootView: PremieresView, viewModel: PremieresViewModel) {
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
        viewModel.fetchPremieres()
    }
}
