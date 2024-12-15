//
//  MockStoresService.swift
//  Products
//
//  Created by Mikhail Bereberdin on 15.12.2024.
//

import Foundation

/// Мок сервиса магазинов.
public struct MockStoresService: IStoresService {
    
    // MARK: - Inits
    
    public init() {}
    
    // MARK: - Methods
    
    public func getStoresAsync() async throws -> [StoreDto] {
        let storesFakeJson = """
[
            {
                "id": 1,
                "name": "ПРОДУКТЫ24",
                "point": {
                    "latitude": "43.53000000000000",
                    "longitude": "43.53000000000000"
                }
            },
            {
                "id": 2,
                "name": "Products Store",
                "point": {
                    "latitude": "43.92452500000000",
                    "longitude": "43.92452500000000"
                }
            },
            {
                "id": 3,
                "name": "Магазин продуктов",
                "point": {
                    "latitude": "45.82000000000000",
                    "longitude": "45.82000000000000"
                }
            }
        ]
"""
        let encodedJson = storesFakeJson.data(using: .utf8)!
        let decodedJson = try JSONDecoder().decode([StoreDto].self, from: encodedJson)
        
        return decodedJson
    }
    
    public func getStorePositionsAsync(id: Int) async throws -> [StorePositionDto] {
        let positionsFakeJson = """
[
  {
    "id": 1,
    "name": "Булочка",
    "imageURL": "https://upload.wikimedia.org/wikipedia/commons/c/c4/Buchteln.jpg",
    "price": 89
  },
  {
    "id": 2,
    "name": "Сок",
    "imageURL": "https://upload.wikimedia.org/wikipedia/commons/5/5a/Oranges_and_orange_juice.jpg",
    "price": 229
  },
  {
    "id": 3,
    "name": "Пюре",
    "imageURL": "https://upload.wikimedia.org/wikipedia/commons/c/c2/Puréed_veggies.jpg",
    "price": 119
  },
  {
    "id": 4,
    "name": "Приправа",
    "imageURL": "https://upload.wikimedia.org/wikipedia/commons/0/01/Hunter_gatherer_food_products.jpg",
    "price": 49
  }
]
"""
        
        let encodedJson = positionsFakeJson.data(using: .utf8)!
        let decodedJson = try JSONDecoder().decode([StorePositionDto].self, from: encodedJson)
        
        return decodedJson
    }
}
