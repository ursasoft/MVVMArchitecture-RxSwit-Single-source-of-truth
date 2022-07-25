import Domain
import Foundation
import Realm
import RealmSwift

public final class UseCaseProvider: Domain.UseCaseProvider {
    // MARK: - PRIVATE PROPERTIES

    private let configuration: Realm.Configuration

    // MARK: - INITIALIZERS

    public init(configuration: Realm.Configuration = Realm.Configuration()) {
        self.configuration = configuration
    }

    // MARK: - PUBLIC METHODS

    public func makePremieresUseCase() -> Domain.PremieresUseCase {
        let repository = Repository<Premiere>(configuration: configuration)
        return PremieresUseCase(repository: repository)
    }
}
