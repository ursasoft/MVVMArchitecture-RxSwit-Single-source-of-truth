import Domain
import Foundation
import RxSwift
import UIKit

final class PremieresUseCase: Domain.PremieresUseCase {
    // MARK: - PRIVATE PROPERTIES

    private let network: PremieresNetwork

    // MARK: - INITIALIZERS

    init(network: PremieresNetwork) {
        self.network = network
    }

    // MARK: - PUBLIC METHODS

    func fetchPremieres() -> Observable<[Premiere]> {
        return network.fetchPremieres()
    }

    func save(premiere: Premiere) -> Observable<Premiere> {
        if premiere.id.isEmpty {
            return network.createPremiere(premiere: premiere)
        } else {
            return network.updatePremiere(premiere: premiere)
        }
    }

    func save(premieres: [Premiere]) -> Observable<[Premiere]> {
        return Observable.create { observer in
            observer.on(.next(premieres))
            observer.on(.completed)
            return Disposables.create()
        }
    }

    func delete(premiere: Premiere) -> Observable<Void> {
        return network.deletePremiere(premiereId: premiere.id).map { _ in }
    }
}
