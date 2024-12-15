//
//  IRegistrationView.swift
//  Products
//
//  Created by Mikhail Bereberdin on 13.11.2024.
//

import Foundation

/// Представление регистрации.
///
/// Отвечает за отображение данных на экране и оповещает Presenter о действиях пользователя.
/// Пассивен, сам никогда не запрашивает данные, только получает их от презентера.
public protocol IRegistrationView: AnyObject {
    
    // MARK: - Fields
    
    /// ``IRegistrationPresenter``.
    var presenter: IRegistrationPresenter! { get set }
    
    /// ``IRegistrationAssembler``.
    var assembler: IRegistrationAssembler! { get }
    
    // MARK: - Methods
    
    /// Настроить ui.
    func configureUI()
    
    /// Настроить тени.
    func configureShadows()
    
    /// Получить значение email.
    ///
    /// - Returns: Значение текстового поля для email.
    func getEmailValue() -> String?
    
    /// Получить значение пароля.
    ///
    /// - Returns: Значение текстового поля для пароля.
    func getPasswordValue() -> String?
    
    /// Получить значение подтвержденного пароля.
    ///
    /// - Returns: Значение текстового поля для подтвержденного пароля.
    func getConfirmPasswordValue() -> String?
    
    /// Показать предупреждение.
    ///
    /// - Parameters:
    ///   - title: Заголовок.
    ///   - description: Описание.
    func showAlert(title: String, description: String)
    
    /// Скрыть клавиатуру.
    func hideKeyboard()
    
    /// Добавить определение нажатия на представление.
    func addViewTapRecognizer()
    
    /// Показать представление авторизации.
    ///
    /// - Parameters:
    ///   - loginView: Представление авторизации.
    ///   - animated: Показывать ли с анимацией.
    func presentLoginView(_ loginView: ILoginView, animated: Bool)
}
