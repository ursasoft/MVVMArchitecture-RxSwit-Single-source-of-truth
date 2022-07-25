import Foundation

public protocol UseCaseProvider {
    func makePremieresUseCase() -> PremieresUseCase
}
