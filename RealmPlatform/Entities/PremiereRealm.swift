import Domain
import Realm
import RealmSwift

final class PremiereRealm: Object {
    @Persisted(primaryKey: true) var id: String
    @Persisted var name: String
    @Persisted var premiereDescription: String
    @Persisted var coverURL: String

    convenience init(object: Premiere) {
        self.init()
        id = object.id
        name = object.name
        premiereDescription = object.description
        coverURL = object.coverURL
    }
}

extension PremiereRealm: DomainConvertibleType {
    func asDomain() -> Premiere {
        return Premiere(id: id,
                        name: name,
                        description: premiereDescription,
                        coverURL: coverURL)
    }
}

extension Premiere: RealmRepresentable {
    func asRealm() -> PremiereRealm {
        return PremiereRealm.build { object in
            object.id = id
            object.name = name
            object.premiereDescription = description
            object.coverURL = coverURL
        }
    }
}
