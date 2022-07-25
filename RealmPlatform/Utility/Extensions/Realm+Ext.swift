import Foundation
import Realm
import RealmSwift
import RxSwift

extension Object {
    static func build<O: Object>(_ builder: (O) -> Void) -> O {
        let object = O()
        builder(object)
        return object
    }
}

extension RealmSwift.SortDescriptor {
    // MARK: - INITIALIZERS

    init(sortDescriptor: NSSortDescriptor) {
        self.init(keyPath: sortDescriptor.key ?? "", ascending: sortDescriptor.ascending)
    }
}

extension Reactive where Base == Realm {
    func save<R: RealmRepresentable>(entity: R, update: Bool = true) -> Observable<R> where R.RealmType: Object {
        return Observable.create { observer in
            do {
                try self.base.write {
                    self.base.add(entity.asRealm(), update: update ? .all : .error)
                }
                observer.onNext(entity)
                observer.onCompleted()
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }

    func save<R: RealmRepresentable>(entities: [R], update: Bool = true) -> Observable<[R]> where R.RealmType: Object {
        return Observable.create { observer in
            do {
                try self.base.write {
                    self.base.deleteAll()

                    entities.forEach { entity in
                        self.base.add(entity.asRealm(), update: update ? .all : .error)
                    }
                }
                observer.onNext(entities)
                observer.onCompleted()
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }

    func delete<R: RealmRepresentable>(entity: R) -> Observable<Void> where R.RealmType: Object {
        return Observable.create { observer in
            do {
                guard let object = self.base.object(ofType: R.RealmType.self, forPrimaryKey: entity.id)
                else { fatalError() }

                try self.base.write {
                    self.base.delete(object)
                }

                observer.onNext(())
                observer.onCompleted()
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
}
