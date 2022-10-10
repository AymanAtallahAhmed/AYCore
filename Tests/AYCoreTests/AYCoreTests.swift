import XCTest
@testable import AYCore

final class AYCoreTests: XCTestCase {
    func testReturnCorrectColorFromHex() {
        let expectedColor = AYCore.colorFrom(hexString: "000000")
        XCTAssertEqual(expectedColor, UIColor.init(red: 0, green: 0, blue: 0, alpha: 1))
    }

    func testAYColorsAreEqual() {
        let expectedColor = AYCore.colorFrom(hexString: "006736")
        XCTAssertEqual(expectedColor, AYCore.mainAYColor)
    }

    func testSecondaryColor() {
        let expectedColor = AYCore.colorFrom(hexString: "FCFFFD")
        XCTAssertEqual(expectedColor, AYCore.secondaryAYColor)
    }
}
