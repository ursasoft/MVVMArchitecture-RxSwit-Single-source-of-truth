import Domain
import Foundation
import UIKit

protocol EditPremiereNavigator {
    func toPremieres()
}

final class DefaultEditPremiereNavigator: EditPremiereNavigator {
    // MARK: - PRIVATE PROPERTIES

    private let navigationController: UINavigationController

    // MARK: - INITIALIZERS

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: - PUBLIC METHODS

    func toPremieres() {
        navigationController.popViewController(animated: true)
    }
}
