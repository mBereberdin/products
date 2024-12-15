//
//  ILoginRouter.swift
//  Products
//
//  Created by Mikhail Bereberdin on 15.11.2024.
//

import Foundation

/// Роутер авторизации.
///
/// Отвечает за навигацию между модулями.
public protocol ILoginRouter: AnyObject {
    
    // MARK: - Fields
    
    /// ``ILoginView``.
    var view: ILoginView! { get set }
    
    // MARK: - Methods
    
    /// Показать представление ближайших магазинов.
    func showNearestStoresView()
}
