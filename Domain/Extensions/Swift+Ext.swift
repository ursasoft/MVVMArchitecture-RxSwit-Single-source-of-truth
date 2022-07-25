import Foundation

// MARK: - EXTENSION DEFINITION

public extension String {
    var isValidRemoteImageUrl: Bool {
        guard let url = URL(string: self),
              url.host != nil, url.scheme != nil, ["jpeg", "jpg", "png"].contains(url.pathExtension)
        else {
            return false
        }
        return true
    }
}
