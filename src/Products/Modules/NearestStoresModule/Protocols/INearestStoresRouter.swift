//
//  INearestStoresRouter.swift
//  Products
//
//  Created by Mikhail Bereberdin on 20.11.2024.
//

import Foundation

/// Роутер ближайших магазинов.
///
/// Отвечает за навигацию между модулями.
public protocol INearestStoresRouter: AnyObject {
    
    // MARK: - Fields
    
    /// ``INearestStoresView``.
    var view: INearestStoresView! { get set }
    
    // MARK: - Methods
    
    /// Показать представление карты ближайших магазинов.
    ///
    /// - Parameter stores: Магазины, которые необходимо отобразить на карте.
    func showNearestStoresMapView(with stores: [StoreDto])
    
    /// Показать представление меню магазина.
    ///
    /// - Parameter storeId: Идентификатор магазина.
    func showStoreMenuView(storeId: Int)
}
