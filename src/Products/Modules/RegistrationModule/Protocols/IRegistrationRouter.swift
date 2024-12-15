//
//  IRegistrationRouter.swift
//  Products
//
//  Created by Mikhail Bereberdin on 09.11.2024.
//

import Foundation

/// Роутер регистрации.
///
/// Отвечает за навигацию между модулями.
public protocol IRegistrationRouter: AnyObject {
    
    // MARK: - Methods
    
    /// Показать окно авторизации.
    func showLoginView()
}
