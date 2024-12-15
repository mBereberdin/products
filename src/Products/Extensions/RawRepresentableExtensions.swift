//
//  RawRepresentableExtensions.swift
//  Products
//
//  Created by Mikhail Bereberdin on 14.11.2024.
//

import Foundation

extension RawRepresentable where RawValue == String, Self: IAPI {
    
    public var url: URL { Self.baseUrl.appendingPathComponent(rawValue) }
}
