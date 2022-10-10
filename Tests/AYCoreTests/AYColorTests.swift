import XCTest
@testable import AYCore

final class AYColorTests: XCTestCase {
    func testReturnCorrectColorFromHex() {
        let expectedColor = AYCore.Color.from(hexString: "000000")
        XCTAssertEqual(expectedColor, UIColor.init(red: 0, green: 0, blue: 0, alpha: 1))
    }

    func testAYColorsAreEqual() {
        let expectedColor = AYCore.Color.from(hexString: "006736")
        XCTAssertEqual(expectedColor, AYCore.Color.mainAYColor)
    }

    func testSecondaryColor() {
        let expectedColor = AYCore.Color.from(hexString: "FCFFFD")
        XCTAssertEqual(expectedColor, AYCore.Color.secondaryAYColor)
    }
}
