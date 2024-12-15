//
//  IRegistrationInteractor.swift
//  Products
//
//  Created by Mikhail Bereberdin on 13.11.2024.
//

import Foundation

/// Интерактор регистрации.
///
/// Содержит всю бизнес-логику, необходимую для работы текущего модуля.
public protocol IRegistrationInteractor: AnyObject {
    
    // MARK: - Methods
    
    /// Проверить корректность пароля.
    ///
    /// - Parameter password: Пароль, который необходимо проверить.
    ///
    /// > Tip:
    /// > - Заглавный символ;
    /// > - прописной символ;
    /// > - число;
    /// > - длина 6+ .
    ///
    /// - Returns: True - если пароль удовлетворяет требованиям, иначе - false.
    func validatePassword(_ password: String) -> Bool
    
    /// Сравнить пароли.
    ///
    /// - Parameters:
    ///   - firstPassword: Первый пароль для сравнения.
    ///   - secondPassword: Второй пароль для сравнения.
    ///
    /// - Returns: True - если пароли равны, иначе - false.
    func comparePasswords(_ firstPassword: String, _ secondPassword: String) -> Bool
    
    /// Зарегистрировать пользователя.
    ///
    /// - Parameters:
    ///   - email: Электронная почта пользователя.
    ///   - password: Пароль пользователя.
    func registerUserAsync(email: String, password: String) async throws
}
