import Domain
@testable import Project
import RxSwift

class EditPremiereNavigatorMock: EditPremiereNavigator {
    var toPremieres_Called = false

    func toPremieres() {
        toPremieres_Called = true
    }
}
