//
//  IRegistrationPresenter.swift
//  Products
//
//  Created by Mikhail Bereberdin on 13.11.2024.
//

import Foundation

/// Презентер регистрации.
///
/// Получает от View информацию о действиях пользователя и преображает ее в запросы к Router’у,
/// Interactor’у, а также получает данные от Interactor’a, подготавливает их и отправляет View для отображения.
public protocol IRegistrationPresenter: AnyObject {
    
    // MARK: - Fields
    
    /// ``IRegistrationView``.
    var view: IRegistrationView! { get set }
    
    /// ``IRegistrationInteractor``.
    var interactor: IRegistrationInteractor! { get set }
    
    /// ``IRegistrationRouter``.
    var router: IRegistrationRouter! { get set }
    
    // Есть подходы с разделением этих методов на Output и Input протоколы, зависит от реализации на проекте.
    
    // MARK: - For Interactor Methods
    
    /// Кнопка регистрации была нажата.
    func registerButtonTapped()
    
    // MARK: For View methods
    
    /// Представление было нажато.
    func viewTapped()
    
    /// Представление было загружено.
    func viewDidLoad()
    
    /// Представление расположило дочерние элементы.
    func viewDidLayoutSubviews()
}
