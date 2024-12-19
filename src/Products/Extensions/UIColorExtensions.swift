//
//  UIColorExtensions.swift
//  Products
//
//  Created by Mikhail Bereberdin on 10.11.2024.
//

import Foundation
import UIKit.UIColor

extension UIColor {
    
    /// Объект, хранящий данные о цвете и иногда о непрозрачности.
    ///
    /// - Parameter hexString: Строка с hex форматом цвета.
    public convenience init(hexString: String) {
        var clearString = hexString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if clearString.hasPrefix("#") {
            clearString.remove(at: clearString.startIndex)
        }
        
        if clearString.count != 6 {
            fatalError("Invalid hex string for color init.")
        }
        
        var rgbValue = UInt64()
        Scanner(string: clearString).scanHexInt64(&rgbValue)
        
        let red = CGFloat(rgbValue >> 16) / 255
        let green = CGFloat(rgbValue >> 8 & 0xFF) / 255
        let blue = CGFloat(rgbValue & 0xFF) / 255
        
        self.init(red: red, green: green, blue: blue, alpha: 1)
    }
}
