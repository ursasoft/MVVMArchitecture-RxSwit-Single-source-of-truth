import Domain
import Foundation

extension Premiere {
    static func mock() -> Premiere {
        Premiere(id: "1",
                 name: "UrsaSoft",
                 description: "Use the potential of the mobile platform",
                 coverURL: "https://ursasoft.io/wp-content/uploads/2019/10/logo_urasoft.png")
    }
}
