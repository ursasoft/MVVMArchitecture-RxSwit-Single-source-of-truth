import Domain
@testable import Project
import RxSwift
import XCTest

class CreatePremiereViewModelTests: XCTestCase {
    func testSave() {
        let localUseCase = PostsUseCaseMock()
        let networkUseCase = PostsUseCaseMock()
        let navigator = CreatePremiereNavigatorMock()
        let createPremiereViewModel = CreatePremiereViewModel(localUseCase: localUseCase,
                                                              networkUseCase: networkUseCase,
                                                              navigator: navigator)
        let input: Input = (name: Observable.just(Premiere.mock().name),
                            coverUrl: Observable.just(Premiere.mock().coverURL),
                            description: Observable.just(Premiere.mock().description))
        createPremiereViewModel.save(input: input)
        XCTAssertTrue(networkUseCase.savePremiere_Called)
        XCTAssertTrue(localUseCase.savePremiere_Called)
    }
}
