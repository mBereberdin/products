//
//  IStoresService.swift
//  Products
//
//  Created by Mikhail Bereberdin on 20.11.2024.
//

import Foundation

/// Сервис для взаимодействия с магазинами.
public protocol IStoresService {
    
    /// Получить магазины.
    func getStoresAsync() async throws -> [StoreDto]
    
    /// Получить позиции магазина.
    ///
    /// - Parameter id: Идентификатор магазина.
    ///
    /// - Returns: Позиции магазина.
    func getStorePositionsAsync(id: Int) async throws -> [StorePositionDto]
}
