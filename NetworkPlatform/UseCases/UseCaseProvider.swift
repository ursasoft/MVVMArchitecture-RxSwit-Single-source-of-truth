import Domain
import Foundation

public final class UseCaseProvider: Domain.UseCaseProvider {
    // MARK: - PRIVATE PROPERTIES

    private let networkProvider: NetworkProvider

    // MARK: - INITIALIZERS

    public init() {
        networkProvider = NetworkProvider()
    }

    // MARK: - PUBLIC METHODS

    public func makePremieresUseCase() -> Domain.PremieresUseCase {
        return PremieresUseCase(network: networkProvider.makePremieresNetwork())
    }
}
