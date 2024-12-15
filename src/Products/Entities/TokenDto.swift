//
//  TokenDto.swift
//  Products
//
//  Created by Mikhail Bereberdin on 14.11.2024.
//

import Foundation

/// Дто токена.
public struct TokenDto: Codable, Sendable {
    
    /// Токен.
    public let token: String
    
    /// Время жизни токена (в секундах?).
    public let tokenLifetime: Int
}
