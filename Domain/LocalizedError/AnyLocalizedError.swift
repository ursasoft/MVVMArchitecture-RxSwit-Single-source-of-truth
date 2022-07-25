import Foundation

public struct AnyLocalizedError: LocalizedError {
    public let errorDescription: String?

    public init(_ errorDescription: String? = nil) {
        self.errorDescription = errorDescription
    }
}
