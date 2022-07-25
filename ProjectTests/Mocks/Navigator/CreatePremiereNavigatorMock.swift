import Domain
@testable import Project
import RxSwift

class CreatePremiereNavigatorMock: CreatePremiereNavigator {
    var toPremieres_Called = false

    func toPremieres() {
        toPremieres_Called = false
    }
}
