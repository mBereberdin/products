//
//  StoresController.swift
//  Products
//
//  Created by Mikhail Bereberdin on 20.11.2024.
//

import Foundation

/// Перечисление конечных точек контроллера магазинов.
public enum StoresController: RawRepresentable, IAPI {
    
    // MARK: - Fields
    
    public static let baseUrl: URL = StoreAPI.baseUrl.appendingPathComponent("stores")
    
    /// Сырое значение.
    public var rawValue: String {
        switch self {
            case .locations:
                return "locations"
                
            case .menu(let id):
                return "\(id)/menu"
        }
    }
    
    // MARK: - Inits
    
    /// ``StoresController``.
    ///
    /// - Parameter rawValue: сырое значение.
    public init?(rawValue: String) {
        switch rawValue {
            case "locations":
                self = .locations
                
            default:
                return nil
        }
    }
    
    // MARK: - Cases
    
    /// Конечная точка локаций магазинов.
    case locations
    
    /// Конечная точка меню магазина.
    case menu(id: Int)
}
