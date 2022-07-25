import Foundation

public enum PremiereValidationError: LocalizedError {
    case invalidName
    case invalidDescription
    case invalidCoverURL

    public var errorDescription: String? {
        switch self {
        case .invalidName:
            return "Invalid name"
        case .invalidDescription:
            return "Invalid description"
        case .invalidCoverURL:
            return "Invalid cover URL"
        }
    }
}
