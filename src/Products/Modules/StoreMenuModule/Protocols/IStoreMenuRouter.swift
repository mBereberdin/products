//
//  IStoreMenuRouter.swift
//  Products
//
//  Created by Mikhail Bereberdin on 04.12.2024.
//

import Foundation

/// Роутер меню магазина.
///
/// Отвечает за навигацию между модулями.
public protocol IStoreMenuRouter: AnyObject {
    
    // MARK: - Fields
    
    /// ``IStoreMenuView``.
    var view: IStoreMenuView! { get set }
    
    // MARK: - Methods
    
    /// Показать представление корзины магазина.
    ///
    /// - Parameter cart: Корзина.
    func showStoreCartView(with cart: [StorePositionDto: Int])
}
