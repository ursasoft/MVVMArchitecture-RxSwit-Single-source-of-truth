import Domain
import Foundation
import UIKit

protocol CreatePremiereNavigator {
    func toPremieres()
}

final class DefaultCreatePremiereNavigator: CreatePremiereNavigator {
    private let navigationController: UINavigationController

    // MARK: - PRIVATE PROPERTIES

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: - PUBLIC METHODS

    func toPremieres() {
        navigationController.popViewController(animated: true)
    }
}
