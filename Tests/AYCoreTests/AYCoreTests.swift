import XCTest
@testable import AYCore

final class AYCoreTests: XCTestCase {
    func testReturnCorrectColorFromHex() {
        let expectedColor = AYCore.colorFrom(hexString: "#ff0000")
        XCTAssertEqual(expectedColor, .red)
    }
}
