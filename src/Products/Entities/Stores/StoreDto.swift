//
//  StoreDto.swift
//  Products
//
//  Created by Mikhail Bereberdin on 20.11.2024.
//

import Foundation

/// ДТО магазина.
public struct StoreDto: Decodable, Sendable {
    
    // MARK: - Fields
    
    /// Идентификатор.
    public let id: Int
    
    /// Наименование.
    public let name: String
    
    /// ``StoreLocationDto``.
    public let location: StoreLocationDto
    
    /// Ключи кодирования.
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case location = "point"
    }
    
    /// ``StoreDto``.
    ///
    /// - Parameter decoder: Декодер для чтения информации.
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.location = try container.decode(StoreLocationDto.self, forKey: .location)
    }
}
