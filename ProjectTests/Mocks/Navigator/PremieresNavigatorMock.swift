import Domain
@testable import Project
import RxSwift

class PremieresNavigatorMock: PremieresNavigator {
    var toPremiere_Called = false
    var toPremieres_Called = false

    func toPremiere(_: Premiere) {
        toPremiere_Called = true
    }

    func toPremieres() {
        toPremieres_Called = false
    }
}
