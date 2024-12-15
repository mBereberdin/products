//
//  StorePositionDto.swift
//  Products
//
//  Created by Mikhail Bereberdin on 06.12.2024.
//

import Foundation

/// Дто позиции магазина.
public struct StorePositionDto: Decodable, Sendable, Hashable {
    
    /// Идентификатор.
    public let id: Int
    
    /// Наименование.
    public let name: String
    
    /// URL изображения.
    public let imageURL: String
    
    /// Цена.
    public let price: Int
}
