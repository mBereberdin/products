//
//  ILoginView.swift
//  Products
//
//  Created by Mikhail Bereberdin on 15.11.2024.
//

import Foundation

/// Представление авторизации.
///
/// Отвечает за отображение данных на экране и оповещает Presenter о действиях пользователя.
/// Пассивен, сам никогда не запрашивает данные, только получает их от презентера.
public protocol ILoginView: AnyObject {
    
    // MARK: - Fields
    
    /// ``ILoginPresenter``.
    var presenter: ILoginPresenter! { get set }
    
    /// ``ILoginAssembler``.
    var assembler: ILoginAssembler { get }
    
    // MARK: - Methods
    
    /// Настроить ui.
    func configureUI()
    
    /// Получить значение email.
    ///
    /// - Returns: Значение текстового поля для email.
    func getEmailValue() -> String?
    
    /// Получить значение пароля.
    ///
    /// - Returns: Значение текстового поля для пароля.
    func getPasswordValue() -> String?
    
    /// Скрыть клавиатуру.
    func hideKeyboard()
    
    /// Добавить определение нажатия на представление.
    func addViewTapRecognizer()
    
    /// Показать предупреждение.
    ///
    /// - Parameters:
    ///   - title: Заголовок.
    ///   - description: Описание.
    func showAlert(title: String, description: String)
    
    /// Показать представление ближайших магазинов.
    ///
    /// - Parameters:
    ///   - nearestStoresView: Представление ближайших магазинов.
    ///   - animated: Показывать ли с анимацией.
    func showNearestStoresView(_ nearestStoresView: INearestStoresView, animated: Bool)
}
