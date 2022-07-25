import Domain
import Foundation
import RxCocoa
import RxSwift

final class CreatePremiereViewModel: BaseViewModel {
    // MARK: - PRIVATE PROPERTIES

    private let localUseCase: PremieresUseCase
    private let networkUseCase: PremieresUseCase
    private let navigator: CreatePremiereNavigator

    // MARK: - INITIALIZERS

    init(localUseCase: PremieresUseCase,
         networkUseCase: PremieresUseCase,
         navigator: CreatePremiereNavigator) {
        self.localUseCase = localUseCase
        self.networkUseCase = networkUseCase
        self.navigator = navigator
    }

    // MARK: - PUBLIC PROPERTIES

    func save(input: Input) {
        toastState.accept(.indicator)

        Observable.combineLatest(input.name, input.description, input.coverUrl)
            .take(1)
            .map { name, description, coverURL in
                let premiere = Premiere(name: name, description: description, coverURL: coverURL)
                try premiere.validate()
                return premiere
            }
            .flatMap { [unowned self] in
                self.networkUseCase.save(premiere: $0)
            }
            .flatMap { [unowned self] in
                self.localUseCase.save(premiere: $0)
            }
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.toastState.accept(.none(action: {
                    self.navigator.toPremieres()
                }))
            }, onError: { [weak self] error in
                self?.toastState.accept(.error(text: error.localizedDescription))
            })
            .disposed(by: disposeBag)
    }
}
