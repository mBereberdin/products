//
//  INearestStoresInteractor.swift
//  Products
//
//  Created by Mikhail Bereberdin on 20.11.2024.
//

import Foundation

/// Интерактор ближайших магазинов.
///
/// Содержит всю бизнес-логику, необходимую для работы текущего модуля.
public protocol INearestStoresInteractor: AnyObject {
    
    // MARK: - Fields
    
    /// ``INearestStoresPresenter``.
    var presenter: INearestStoresPresenter! { get set }
    
    /// Преобразованные магазины.
    var mappedStores: [(name: String, distance: Int?)] { get }
    
    /// Магазины.
    var stores: [StoreDto] { get }
    
    // MARK: - Methods
    
    /// Загрузить магазины.
    func loadStoresAsync() async throws
    
    /// Рассчитать расстояния от магазинов до пользователя.
    func calculateStoresDistanceAsync() async throws
    
    /// Проверить доступ к локации пользователя.
    func checkLocationAuthorization()
    
    /// Установить обработку изменения доступа к локации пользователя.
    ///
    /// - Parameter handler: Обработка изменения доступа к локации пользователя.
    func setOnLocationAuthorizationChange(handler: @escaping()->())
}
