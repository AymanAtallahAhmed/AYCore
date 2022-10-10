import UIKit

public class AYCore {
    /// Converts hex color to UIColor.
    /// - Parameters:
    ///   - hexString: A string contains hex color.
    ///   - alpha: Alpha wanted.
    /// - Returns: A UIColor from the given hex.
    class func colorFrom(hexString: String, with alpha: CGFloat = 1) -> UIColor {
        let r, g, b: CGFloat
        let offset = hexString.contains("#") ? 1 : 0
        let start = hexString.index(hexString.startIndex, offsetBy: offset)
        let hexColor = String(hexString[start...])
        let scanner = Scanner(string: hexColor)
        var hexNumber: UInt64 = 0
        if scanner.scanHexInt64(&hexNumber) {
            r = CGFloat((hexNumber & 0xff0000) >> 16) / 256
            g = CGFloat((hexNumber & 0x00ff00) >> 8) / 256
            b = CGFloat(hexNumber & 0x0000ff) / 256
            return UIColor(red: r, green: g, blue: b, alpha: alpha)
        }
        return UIColor(red: 0, green: 0, blue: 0, alpha: alpha)
    }

    public static var AYColor: UIColor {
        colorFrom(hexString: "006736")
    }
}
