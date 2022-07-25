import Foundation
import RxSwift

public protocol PremieresUseCase {
    func fetchPremieres() -> Observable<[Premiere]>
    func save(premiere: Premiere) -> Observable<Premiere>
    func save(premieres: [Premiere]) -> Observable<[Premiere]>
    func delete(premiere: Premiere) -> Observable<Void>
}
