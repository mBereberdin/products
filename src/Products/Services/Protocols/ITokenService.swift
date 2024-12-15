//
//  ITokenService.swift
//  Products
//
//  Created by Mikhail Bereberdin on 18.11.2024.
//

import Foundation

/// Сервис для взаимодействия с токеном.
public protocol ITokenService {
    
    // MARK: - Fields
    
    /// Общий экземпляр сервиса взаимодействия с токеном.
    ///
    /// > Warning: Инициализируется после авторизации пользователем в ``LoginView``.
    static var shared: ITokenService! { get }
    
    /// Текущий токен.
    var currentToken: TokenDto { get }
}
