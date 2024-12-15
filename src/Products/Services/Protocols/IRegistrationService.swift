//
//  IRegistrationService.swift
//  Products
//
//  Created by Mikhail Bereberdin on 14.11.2024.
//

import Foundation

/// Сервис для взаимодействия с контроллером регистрации.
public protocol IRegistrationService {
    
    /// Отправить запрос регистрации.
    ///
    /// - Parameter loginData: ``LoginDataDto``.
    func sendRegisterRequestAsync(loginData: LoginDataDto) async throws
    
    /// Отправить запрос авторизации.
    ///
    /// - Parameter loginData: ``LoginDataDto``.
    func sendLoginRequestAsync(loginData: LoginDataDto) async throws -> TokenDto 
}
