//
//  StoreAPI.swift
//  Products
//
//  Created by Mikhail Bereberdin on 14.11.2024.
//

import Foundation

/// Перечисление API сервиса магазинов.
public enum StoreAPI: IAPI {
    
    public static let baseUrl = URL(string: "http://localhost:5432/")!
    
    /// ``AuthController``.
    public static let auth = AuthController.self
    
    /// ``StoresController``.
    public static let stores = StoresController.self
}
