import Alamofire
import Domain
import Foundation
import RxAlamofire
import RxSwift

final class Network<T: Codable> {
    // MARK: - PRIVATE PROPERTIES

    private let endPoint: String
    private let scheduler: ConcurrentDispatchQueueScheduler

    // MARK: - INITIALIZERS

    init(_ endPoint: String) {
        self.endPoint = endPoint
        scheduler = ConcurrentDispatchQueueScheduler(qos:
            DispatchQoS(qosClass: DispatchQoS.QoSClass.background, relativePriority: 1)
        )
    }

    // MARK: - PUBLIC METHODS

    func getItems(_ path: String) -> Observable<[T]> {
        let absolutePath = "\(endPoint)/\(path)"
        return RxAlamofire
            .data(.get, absolutePath)
            // .debug()
            .observe(on: scheduler)
            .map { data -> [T] in
                try JSONDecoder().decode([T].self, from: data)
            }
    }

    func getItem(_ path: String, itemId: String) -> Observable<T> {
        let absolutePath = "\(endPoint)/\(path)/\(itemId)"
        return RxAlamofire
            .data(.get, absolutePath)
            // .debug()
            .observe(on: scheduler)
            .map { data -> T in
                try JSONDecoder().decode(T.self, from: data)
            }
    }

    func postItem(_ path: String, object: T) -> Observable<T> {
        let absolutePath = "\(endPoint)/\(path)"
        return RxAlamofire
            .request(.post, absolutePath, parameters: object.toDictionary(), encoding: JSONEncoding.default)
            // .debug()
            .observe(on: scheduler)
            .data()
            .map { data -> T in
                try JSONDecoder().decode(T.self, from: data)
            }
    }

    func updateItem(_ path: String, itemId: String, object: T) -> Observable<T> {
        let absolutePath = "\(endPoint)/\(path)/\(itemId)"
        return RxAlamofire
            .request(.put, absolutePath, parameters: object.toDictionary(), encoding: JSONEncoding.default)
            // .debug()
            .observe(on: scheduler)
            .response()
            .map { response -> T in
                guard response.statusCode == 200 else {
                    throw AnyLocalizedError("Update failed - incorrect status code for response")
                }
                return object
            }
    }

    func deleteItem(_ path: String, itemId: String) -> Observable<Void> {
        let absolutePath = "\(endPoint)/\(path)/\(itemId)"
        return RxAlamofire
            .request(.delete, absolutePath)
            // .debug()
            .observe(on: scheduler)
            .response()
            .map { response in
                guard response.statusCode == 200 else {
                    throw AnyLocalizedError("Delete failed - incorrect status code for response")
                }
            }
    }
}
