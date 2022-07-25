import Foundation
import Realm
import RealmSwift
import RxRealm
import RxSwift

protocol AbstractRepository {
    associatedtype T
    func queryAll() -> Observable<[T]>
    func query(with predicate: NSPredicate,
               sortDescriptors: [NSSortDescriptor]) -> Observable<[T]>
    func save(entity: T) -> Observable<T>
    func save(entities: [T]) -> Observable<[T]>
    func delete(entity: T) -> Observable<Void>
}

final class Repository<T: RealmRepresentable>: AbstractRepository
    where T == T.RealmType.DomainType, T.RealmType: Object {
    // MARK: - PRIVATE PROPERTIES

    private let configuration: Realm.Configuration
    private let scheduler: RunLoopThreadScheduler

    // swiftlint:disable force_try
    private var realm: Realm {
        return try! Realm(configuration: configuration)
    }

    // swiftlint:enable force_try

    // MARK: - INITIALIZERS

    init(configuration: Realm.Configuration) {
        self.configuration = configuration
        scheduler = RunLoopThreadScheduler(threadName: "io.ursasoft.Project.RealmPlatform.Repository")
        // print("File url: \(RLMRealmPathForFile("default.realm"))")
    }

    // MARK: - PUBLIC METHODS

    func queryAll() -> Observable<[T]> {
        return Observable.deferred { [unowned self] in
            let realm = self.realm
            let objects = realm.objects(T.RealmType.self)
            return Observable.collection(from: objects).mapToDomain()
        }
        .subscribe(on: scheduler)
    }

    func query(with _: NSPredicate,
               sortDescriptors _: [NSSortDescriptor] = []) -> Observable<[T]> {
        return Observable.deferred { [unowned self] in
            let realm = self.realm
            let objects = realm.objects(T.RealmType.self)
            return Observable.collection(from: objects).mapToDomain()
        }
        .subscribe(on: scheduler)
    }

    func save(entity: T) -> Observable<T> {
        return Observable.deferred { [unowned self] in
            self.realm.rx.save(entity: entity)
        }.subscribe(on: scheduler)
    }

    func save(entities: [T]) -> Observable<[T]> {
        return Observable.deferred { [unowned self] in
            self.realm.rx.save(entities: entities)
        }.subscribe(on: scheduler)
    }

    func delete(entity: T) -> Observable<Void> {
        return Observable.deferred { [unowned self] in
            self.realm.rx.delete(entity: entity)
        }.subscribe(on: scheduler)
    }
}
