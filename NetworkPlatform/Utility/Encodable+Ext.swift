import Foundation

extension Encodable {
    func toDictionary(_ encoder: JSONEncoder = JSONEncoder()) -> [String: Any] {
        guard let data = try? encoder.encode(self),
              let object = try? JSONSerialization.jsonObject(with: data),
              var json = object as? [String: Any]
        else { return [:] }
        json.removeValue(forKey: "_id")
        return json
    }
}
