@testable import Domain
import XCTest

class DomainTests: XCTestCase {
    func testPremiereValidate() {
        let premiereEmptyName = Premiere(name: "", description: "", coverURL: "")
        XCTAssertThrowsError(try premiereEmptyName.validate()) { error in
            XCTAssertEqual(error as? PremiereValidationError, PremiereValidationError.invalidName)
        }

        let premiereInvalidName = Premiere(name: "te", description: "", coverURL: "")
        XCTAssertThrowsError(try premiereInvalidName.validate()) { error in
            XCTAssertEqual(error as? PremiereValidationError, PremiereValidationError.invalidName)
        }

        let premiereEmptyDescription = Premiere(name: "test", description: "", coverURL: "")
        XCTAssertThrowsError(try premiereEmptyDescription.validate()) { error in
            XCTAssertEqual(error as? PremiereValidationError, PremiereValidationError.invalidDescription)
        }

        let premiereInvalidDescription = Premiere(name: "test", description: "shorttext", coverURL: "")
        XCTAssertThrowsError(try premiereInvalidDescription.validate()) { error in
            XCTAssertEqual(error as? PremiereValidationError, PremiereValidationError.invalidDescription)
        }

        let premiereEmptyCoverUrl = Premiere(name: "test", description: "long description", coverURL: "")
        XCTAssertThrowsError(try premiereEmptyCoverUrl.validate()) { error in
            XCTAssertEqual(error as? PremiereValidationError, PremiereValidationError.invalidCoverURL)
        }

        let premiereInvalidCoverUrl = Premiere(name: "test", description: "long description", coverURL: "test")
        XCTAssertThrowsError(try premiereInvalidCoverUrl.validate()) { error in
            XCTAssertEqual(error as? PremiereValidationError, PremiereValidationError.invalidCoverURL)
        }
        let coverUrl = "https://i.pinimg.com/originals/53/95/ff/5395ff3fd2be3dc7b14de8f8db3b11ba.jpg"
        let premiere = Premiere(name: "test", description: "long description", coverURL: coverUrl)
        XCTAssertNoThrow(try premiere.validate())
    }
}
