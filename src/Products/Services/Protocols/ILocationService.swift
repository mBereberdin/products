//
//  ILocationService.swift
//  Products
//
//  Created by Mikhail Bereberdin on 22.11.2024.
//

import Foundation

/// Сервис для взаимодействия с локациями.
public protocol ILocationService {
    
    /// Получить расстояние до пользователя (в метрах).
    ///
    /// - Parameters:
    ///   - latitude: Долгота, от которой необходимо получить расстояние до пользователя.
    ///   - longitude: Широта, от которой необходимо получить расстояние до пользователя.
    ///
    /// - Returns: Расстояние до пользователя (в метрах), если удалось рассчитать, иначе - nil.
    func getDistanceToUserAsync(latitude: Double, longitude: Double) async -> Int?
    
    /// Проверить доступ к локации пользователя.
    func checkLocationAuthorization()
    
    /// Установить обработку изменения доступа к локации пользователя.
    ///
    /// - Parameter handler: Обработка изменения доступа к локации пользователя.
    func setOnLocationAuthorizationChange(handler: @escaping()->())
}
