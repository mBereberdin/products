//
//  INearestStoresMapRouter.swift
//  Products
//
//  Created by Mikhail Bereberdin on 02.12.2024.
//

import Foundation

/// Роутер карты ближайших магазинов.
///
/// Отвечает за навигацию между модулями.
public protocol INearestStoresMapRouter: AnyObject {
    
    // MARK: - Fields
    
    /// ``INearestStoresView``.
    var view: INearestStoresMapView! { get set }
    
    // MARK: - Methods
    
    /// Показать представление меню магазина.
    ///
    /// - Parameter storeId: Идентификатор магазина.
    func showStoreMenuView(storeId: Int)
}
