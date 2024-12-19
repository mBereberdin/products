//
//  LoginDataDto.swift
//  Products
//
//  Created by Mikhail Bereberdin on 13.11.2024.
//

import Foundation

/// Дто информации для авторизации.
public struct LoginDataDto: Codable, Sendable {
    
    /// Логин (почта.)
    public let login: String
    
    /// Пароль.
    public let password: String
}
