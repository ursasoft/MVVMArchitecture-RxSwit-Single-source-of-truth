import Foundation

public struct Premiere: Codable {
    // MARK: - PUBLIC PROPERTIES

    public let id: String
    public let name: String
    public let description: String
    public let coverURL: String

    // MARK: - PRIVATE PROPERTIES

    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case description
        case coverURL
    }

    // MARK: - INITIALIZERS

    public init(id: String = "",
                name: String,
                description: String,
                coverURL: String) {
        self.id = id
        self.name = name
        self.description = description
        self.coverURL = coverURL
    }

    // MARK: - PUBLIC METHODS

    public func validate() throws {
        if name.count < 3 {
            throw PremiereValidationError.invalidName
        }
        if description.count < 10 {
            throw PremiereValidationError.invalidDescription
        }
        if !coverURL.isValidRemoteImageUrl {
            throw PremiereValidationError.invalidCoverURL
        }
    }
}
