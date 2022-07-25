import Domain
import Foundation
import RxCocoa
import RxSwift

final class PremieresViewModel: BaseViewModel {
    // MARK: - PUBLIC PROPERTIES

    var premieres = BehaviorRelay<[Premiere]>(value: [])

    // MARK: - PRIVATE PROPERTIES

    private let localUseCase: PremieresUseCase
    private let networkUseCase: PremieresUseCase
    private let navigator: PremieresNavigator

    // MARK: - INITIALIZERS

    init(localUseCase: PremieresUseCase,
         networkUseCase: PremieresUseCase,
         navigator: PremieresNavigator) {
        self.localUseCase = localUseCase
        self.networkUseCase = networkUseCase
        self.navigator = navigator
        super.init()

        observeLocalPremieres()
    }

    // MARK: - PUBLIC METHODS

    func fetchPremieres() {
        toastState.accept(.indicator)

        networkUseCase.fetchPremieres()
            .flatMap { [unowned self] in
                self.localUseCase.save(premieres: $0)
            }
            .subscribe(onNext: { [weak self] premieres in
                guard let self = self else { return }
                self.toastState.accept(.none(action: nil))
                self.premieres.accept(premieres)
            }, onError: { [weak self] error in
                self?.toastState.accept(.error(text: error.localizedDescription))
            })
            .disposed(by: disposeBag)
    }

    func showDetails(_ premiere: Premiere) {
        navigator.toPremiere(premiere)
    }

    // MARK: - PRIVATE METHODS

    private func observeLocalPremieres() {
        localUseCase.fetchPremieres()
            .bind(to: premieres)
            .disposed(by: disposeBag)
    }
}
