import XCTest
@testable import AYCore

final class AYCoreTests: XCTestCase {
    func testReturnCorrectColorFromHex() {
        let expectedColor = AYCore.colorFrom(hexString: "000000")
        XCTAssertEqual(expectedColor, UIColor.init(red: 0, green: 0, blue: 0, alpha: 1))
    }
}
