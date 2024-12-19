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
    
    // MARK: - Fields
    
    /// Действия при получении доступа к локации пользователя.
    var onAuthorised: (()->())? { get set }
    
    /// Есть ли доступ к локации пользователя.
    var isAuthorised: Bool { get }
    
    // MARK: - Methods
    
    /// Получить локацию пользователя.
    ///
    /// - Returns: Локацию пользователя.
    func getUserLocationAsync() async throws -> CLLocation
    
    /// Проверить доступ к локации пользователя.
    func checkLocationAuthorization()
}
