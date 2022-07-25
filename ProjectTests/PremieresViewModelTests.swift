import Domain
@testable import Project
import RxSwift
import XCTest

class PremieresViewModelTests: XCTestCase {
    func testInit() {
        let localUseCase = PostsUseCaseMock()
        let networkUseCase = PostsUseCaseMock()
        let navigator = PremieresNavigatorMock()
        _ = PremieresViewModel(localUseCase: localUseCase,
                               networkUseCase: networkUseCase,
                               navigator: navigator)
        XCTAssertTrue(localUseCase.premieres_Called)
    }

    func testFetchPremieres() {
        let localUseCase = PostsUseCaseMock()
        let networkUseCase = PostsUseCaseMock()
        let navigator = PremieresNavigatorMock()
        let premieresViewModel = PremieresViewModel(localUseCase: localUseCase,
                                                    networkUseCase: networkUseCase,
                                                    navigator: navigator)
        premieresViewModel.fetchPremieres()
        XCTAssertTrue(networkUseCase.premieres_Called)
        XCTAssertTrue(localUseCase.savePremieres_Called)
    }

    func testShowDetails() {
        let localUseCase = PostsUseCaseMock()
        let networkUseCase = PostsUseCaseMock()
        let navigator = PremieresNavigatorMock()
        let premiere = PremieresViewModel(localUseCase: localUseCase,
                                          networkUseCase: networkUseCase,
                                          navigator: navigator)
        premiere.showDetails(Premiere.mock())
        XCTAssertTrue(navigator.toPremiere_Called)
    }
}
