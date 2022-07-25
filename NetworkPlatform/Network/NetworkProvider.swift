import Domain

final class NetworkProvider {
    private let apiEndpoint: String

    // MARK: - INITIALIZERS

    public init() {
        apiEndpoint = Config.apiEndpoint
    }

    // MARK: - PUBLIC METHODS

    public func makePremieresNetwork() -> PremieresNetwork {
        let network = Network<Premiere>(apiEndpoint)
        return PremieresNetworkImp(network: network)
    }
}
