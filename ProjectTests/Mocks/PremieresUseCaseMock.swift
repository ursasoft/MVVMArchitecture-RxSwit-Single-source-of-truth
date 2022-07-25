import Domain
@testable import Project
import RxSwift

class PostsUseCaseMock: Domain.PremieresUseCase {
    var premieres_Called = false
    var savePremiere_Called = false
    var savePremieres_Called = false
    var deletePremieres_Called = false

    func fetchPremieres() -> Observable<[Premiere]> {
        premieres_Called = true
        return Observable.just([])
    }

    func save(premiere: Premiere) -> Observable<Premiere> {
        savePremiere_Called = true
        return Observable.just(premiere)
    }

    func save(premieres: [Premiere]) -> Observable<[Premiere]> {
        savePremieres_Called = true
        return Observable.just(premieres)
    }

    func delete(premiere _: Premiere) -> Observable<Void> {
        deletePremieres_Called = true
        return Observable.just(())
    }
}
