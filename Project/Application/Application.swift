import Domain
import Foundation
import NetworkPlatform
import RealmPlatform

final class Application {
    private let localProvider: Domain.UseCaseProvider
    private let networkProvider: Domain.UseCaseProvider

    // MARK: - INITIALIZERS

    init() {
        localProvider = RealmPlatform.UseCaseProvider()
        networkProvider = NetworkPlatform.UseCaseProvider()
    }

    // MARK: - PUBLIC METHODS

    func configureMainInterface(in window: UIWindow) {
        UINavigationBar.setDefaultAppearance()

        let navigationController = UINavigationController()
        let navigator = DefaultPremieresNavigator(localProvider: localProvider,
                                                  networkProvider: networkProvider,
                                                  navigationController: navigationController)

        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        navigator.toPremieres()
    }
}
