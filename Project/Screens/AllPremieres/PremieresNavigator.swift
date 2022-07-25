import Domain
import UIKit

public protocol PremieresNavigator {
    func toPremiere(_ premiere: Premiere)
    func toPremieres()
}

class DefaultPremieresNavigator: PremieresNavigator {
    // MARK: - PRIVATE PROPERTIES

    private let navigationController: UINavigationController
    private let localUseCase: PremieresUseCase
    private let networkUseCase: PremieresUseCase

    // MARK: - INITIALIZERS

    init(localProvider: UseCaseProvider,
         networkProvider: UseCaseProvider,
         navigationController: UINavigationController) {
        localUseCase = localProvider.makePremieresUseCase()
        networkUseCase = networkProvider.makePremieresUseCase()
        self.navigationController = navigationController
    }

    // MARK: - PUBLIC METHODS

    func toPremieres() {
        let viewModel = PremieresViewModel(localUseCase: localUseCase,
                                           networkUseCase: networkUseCase,
                                           navigator: self)
        let rootView = PremieresView(viewModel: viewModel)
        let viewController = PremieresViewController(rootView: rootView, viewModel: viewModel)
        viewController.title = "Premieres"
        let btn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(toCreatePremiere))
        viewController.navigationItem.rightBarButtonItem = btn
        navigationController.pushViewController(viewController, animated: true)
    }

    func toPremiere(_ premiere: Premiere) {
        let navigator = DefaultEditPremiereNavigator(navigationController: navigationController)
        let viewModel = EditPremiereViewModel(premiere: premiere,
                                              localUseCase: localUseCase,
                                              networkUseCase: networkUseCase,
                                              navigator: navigator)
        let rootView = EditPremiereView(viewModel: viewModel)
        let viewController = EditPremiereViewController(rootView: rootView, viewModel: viewModel)
        viewController.title = premiere.name
        viewController.navigationItem.rightBarButtonItems = [
            UIBarButtonItem(barButtonSystemItem: .save, target: nil, action: nil),
            UIBarButtonItem(barButtonSystemItem: .trash, target: nil, action: nil),
        ]
        navigationController.pushViewController(viewController, animated: true)
    }

    // MARK: - PRIVATE METHODS

    @objc private func toCreatePremiere() {
        let navigator = DefaultCreatePremiereNavigator(navigationController: navigationController)
        let viewModel = CreatePremiereViewModel(localUseCase: localUseCase,
                                                networkUseCase: networkUseCase,
                                                navigator: navigator)
        let rootView = CreatePremiereView(viewModel: viewModel)
        let viewController = CreatePremiereViewController(rootView: rootView, viewModel: viewModel)
        viewController.title = "Create Premiere"
        let btn = UIBarButtonItem(barButtonSystemItem: .save, target: nil, action: nil)
        viewController.navigationItem.rightBarButtonItem = btn
        navigationController.pushViewController(viewController, animated: true)
    }
}
