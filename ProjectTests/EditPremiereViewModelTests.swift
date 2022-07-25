import Domain
@testable import Project
import RxSwift
import XCTest

class EditPremiereViewModelTests: XCTestCase {
    func testSave() {
        let localUseCase = PostsUseCaseMock()
        let networkUseCase = PostsUseCaseMock()
        let navigator = EditPremiereNavigatorMock()
        let editPremiereViewModel = EditPremiereViewModel(premiere: Premiere.mock(),
                                                          localUseCase: localUseCase,
                                                          networkUseCase: networkUseCase,
                                                          navigator: navigator)
        let input: Input = (name: Observable.just(Premiere.mock().name),
                            coverUrl: Observable.just(Premiere.mock().coverURL),
                            description: Observable.just(Premiere.mock().description))
        editPremiereViewModel.save(input: input)
        XCTAssertTrue(networkUseCase.savePremiere_Called)
        XCTAssertTrue(localUseCase.savePremiere_Called)
    }

    func testDelete() {
        let localUseCase = PostsUseCaseMock()
        let networkUseCase = PostsUseCaseMock()
        let navigator = EditPremiereNavigatorMock()
        let editPremiereViewModel = EditPremiereViewModel(premiere: Premiere.mock(),
                                                          localUseCase: localUseCase,
                                                          networkUseCase: networkUseCase,
                                                          navigator: navigator)
        editPremiereViewModel.delete()
        XCTAssertTrue(networkUseCase.deletePremieres_Called)
        XCTAssertTrue(localUseCase.deletePremieres_Called)
    }
}
