//
//  ILoginInteractor.swift
//  Products
//
//  Created by Mikhail Bereberdin on 15.11.2024.
//

import Foundation

/// Интерактор авторизации.
///
/// Содержит всю бизнес-логику, необходимую для работы текущего модуля.
public protocol ILoginInteractor: AnyObject {
    
    // MARK: - Fields
    
    /// ``ILoginPresenter``.
    var presenter: ILoginPresenter! { get set }
    
    // MARK: - Methods
    
    /// Авторизовать пользователя.
    ///
    /// - Parameters:
    ///   - email: Электронная почта пользователя.
    ///   - password: Пароль пользователя.
    func loginUserAsync(email: String, password: String) async throws
}
