//
//  Color.swift
//
//
//  Created by Ayman Ata on 10/10/2022.
//

import UIKit

extension AYCore {
    public class Color {
        /// Converts hex color to UIColor.
        /// - Parameters:
        ///   - hexString: A string contains hex color.
        ///   - alpha: Alpha wanted.
        /// - Returns: A UIColor from the given hex.
        class func from(hexString: String, with alpha: CGFloat = 1) -> UIColor {
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
        
        /// Most pleasing color for humans.
        public static var mainAYColor: UIColor {
            from(hexString: "006736")
        }
        
        /// Second most pleasing color for humans.
        public static var secondaryAYColor: UIColor {
            from(hexString: "FCFFFD")
        }
    }
}
