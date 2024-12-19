//
//  ILocationManager.swift
//  Products
//
//  Created by Mikhail Bereberdin on 25.11.2024.
//

import Foundation
import CoreLocation.CLLocation

/// Менеджер локации.
public protocol ILocationManager {
    
    /// Получить локацию пользователя.
    ///
    /// - Returns: Локацию пользователя.
    func getUserLocationAsync() async throws -> CLLocation
}
