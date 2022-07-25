import Domain
import RxCocoa
import RxSwift
import UIKit

class EditPremiereViewController: BaseViewController {
    // MARK: - PRIVATE PROPERTIES

    private let rootView: EditPremiereView
    private let viewModel: EditPremiereViewModel!

    // MARK: - INITIALIZERS

    init(rootView: EditPremiereView, viewModel: EditPremiereViewModel) {
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

        if let rightBarButtonItems = navigationItem.rightBarButtonItems,
           let saveButton = rightBarButtonItems[safe: 0],
           let deleteButton = rightBarButtonItems[safe: 1] {
            saveButton.tap.bind { [weak self] in
                guard let self = self else { return }
                self.viewModel.save(input: self.rootView.input)
            }.disposed(by: viewModel.disposeBag)

            deleteButton.tap.bind { [weak self] in
                let yesAction = UIAlertAction(title: "Yes", style: .destructive, handler: { [weak self] _ in
                    self?.viewModel.delete()
                })
                let noAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
                let alert = UIAlertController.alert(title: "Delete Premiere",
                                                    message: "Are you sure you want to delete this premiere?",
                                                    actions: [yesAction, noAction])
                self?.present(alert, animated: true, completion: nil)
            }.disposed(by: viewModel.disposeBag)
        }
    }
}
