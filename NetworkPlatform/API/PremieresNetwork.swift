import Domain
import RxSwift

public protocol PremieresNetwork {
    func fetchPremieres() -> Observable<[Premiere]>
    func fetchPremiere(premiereId: String) -> Observable<Premiere>
    func createPremiere(premiere: Premiere) -> Observable<Premiere>
    func updatePremiere(premiere: Premiere) -> Observable<Premiere>
    func deletePremiere(premiereId: String) -> Observable<Void>
}

public final class PremieresNetworkImp: PremieresNetwork {
    // MARK: - PRIVATE PROPERTIES

    private let network: Network<Premiere>

    // MARK: - INITIALIZERS

    init(network: Network<Premiere>) {
        self.network = network
    }

    // MARK: - PUBLIC METHODS

    public func fetchPremieres() -> Observable<[Premiere]> {
        return network.getItems("movies")
    }

    public func fetchPremiere(premiereId: String) -> Observable<Premiere> {
        return network.getItem("movies", itemId: premiereId)
    }

    public func createPremiere(premiere: Premiere) -> Observable<Premiere> {
        return network.postItem("movies", object: premiere)
    }

    public func updatePremiere(premiere: Premiere) -> Observable<Premiere> {
        return network.updateItem("movies", itemId: premiere.id, object: premiere)
    }

    public func deletePremiere(premiereId: String) -> Observable<Void> {
        return network.deleteItem("movies", itemId: premiereId)
    }
}
