//
//  AuthController.swift
//  Products
//
//  Created by Mikhail Bereberdin on 14.11.2024.
//

import Foundation

/// Перечисление конечных точек контроллера авторизации.
public enum AuthController: RawRepresentable, IAPI {
    
    // MARK: - Fields
    
    public static let baseUrl: URL = StoreAPI.baseUrl.appendingPathComponent("auth")
    
    /// Сырое значение.
    public var rawValue: String {
        switch self {
            case .register:
                return "register"
                
            case .login:
                return "login"
        }
    }
    
    // MARK: - Inits
    
    /// ``AuthController``.
    ///
    /// - Parameter rawValue: сырое значение.
    public init?(rawValue: String) {
        switch rawValue {
            case "register":
                self = .register
                
            case "login":
                self = .login
                
            default:
                return nil
        }
    }
    
    // MARK: - Cases
    
    /// Конечная точка регистрации.
    case register
    
    /// Конечная точка авторизации.
    case login
}
