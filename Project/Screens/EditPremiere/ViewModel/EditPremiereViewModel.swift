import Domain
import RxCocoa
import RxSwift

final class EditPremiereViewModel: BaseViewModel {
    // MARK: - PUBLIC PROPERTIES

    let premiere: Premiere

    // MARK: - PRIVATE PROPERTIES

    private let localUseCase: PremieresUseCase
    private let networkUseCase: PremieresUseCase
    private let navigator: EditPremiereNavigator

    // MARK: - INITIALIZERS

    init(premiere: Premiere,
         localUseCase: PremieresUseCase,
         networkUseCase: PremieresUseCase,
         navigator: EditPremiereNavigator) {
        self.premiere = premiere
        self.localUseCase = localUseCase
        self.networkUseCase = networkUseCase
        self.navigator = navigator
    }

    // MARK: - PUBLIC METHODS

    func save(input: Input) {
        toastState.accept(.indicator)

        let premiereDetails = Observable.combineLatest(input.name, input.description, input.coverUrl)
        Observable.combineLatest(Observable.just(premiere), premiereDetails)
            .take(1)
            .map { premiere, premiereDetails -> Premiere in
                let premiere = Premiere(id: premiere.id,
                                        name: premiereDetails.0,
                                        description: premiereDetails.1,
                                        coverURL: premiereDetails.2)
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
            }).disposed(by: disposeBag)
    }

    func delete() {
        toastState.accept(.indicator)

        networkUseCase.delete(premiere: premiere)
            .flatMap { [unowned self] _ in
                self.localUseCase.delete(premiere: self.premiere)
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
