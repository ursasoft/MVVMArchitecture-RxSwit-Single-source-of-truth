import Domain
import Foundation
import Realm
import RealmSwift
import RxSwift

final class PremieresUseCase<Repository>: Domain.PremieresUseCase
    where Repository: AbstractRepository, Repository.T == Premiere {
    // MARK: - PRIVATE PROPERTIES

    private let repository: Repository

    // MARK: - INITIALIZERS

    init(repository: Repository) {
        self.repository = repository
    }

    // MARK: - PUBLIC METHODS

    func fetchPremieres() -> Observable<[Premiere]> {
        return repository.queryAll()
    }

    func save(premiere: Premiere) -> Observable<Premiere> {
        return repository.save(entity: premiere)
    }

    func save(premieres: [Premiere]) -> Observable<[Premiere]> {
        return repository.save(entities: premieres)
    }

    func delete(premiere: Premiere) -> Observable<Void> {
        return repository.delete(entity: premiere)
    }
}
