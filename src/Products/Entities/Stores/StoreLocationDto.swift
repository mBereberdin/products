//
//  StoreLocationDto.swift
//  Products
//
//  Created by Mikhail Bereberdin on 20.11.2024.
//

import Foundation

/// ДТО локации магазина.
public struct StoreLocationDto: Decodable, Sendable {
    
    // MARK: - Fields
    
    /// Широта.
    public let latitude: Double
    
    /// Долгота.
    public let longitude: Double
    
    /// Ключи кодирования.
    private enum CodingKeys: CodingKey {
        case latitude
        case longitude
    }
    
    // MARK: - Inits
    
    /// ``StoreLocationDto``.
    ///
    /// - Parameter decoder: Декодер для чтения информации.
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let stringLatitude = try container.decode(String.self, forKey: .latitude)
        let stringLongitude = try container.decode(String.self, forKey: .longitude)
        
        guard let mappedLatitude = Double(stringLatitude),
              let mappedLongitude = Double(stringLongitude) else {
            // TODO: Выбрасывать кастомную ошибку.
            
            fatalError("Cannot map store location.")
        }
        
        self.latitude = mappedLatitude
        self.longitude = mappedLongitude
    }
}
