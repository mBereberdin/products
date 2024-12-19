//
//  ILoginPresenter.swift
//  Products
//
//  Created by Mikhail Bereberdin on 15.11.2024.
//

import Foundation

/// Презентер авторизации.
///
/// Получает от View информацию о действиях пользователя и преображает ее в запросы к Router’у,
/// Interactor’у, а также получает данные от Interactor’a, подготавливает их и отправляет View для отображения.
public protocol ILoginPresenter: AnyObject {
    
    // MARK: - Fields
    
    /// ``ILoginView``.
    var view: ILoginView! { get set }
    
    /// ``ILoginInteractor``.
    var interactor: ILoginInteractor! { get set }
    
    /// ``ILoginRouter``.
    var router: ILoginRouter! { get set }
    
    // MARK: - Methods
    
    /// Кнопка авторизации была нажата.
    func loginButtonTapped()
    
    /// Представление было нажато.
    func viewTapped()
    
    /// Представление было загружено.
    func viewDidLoad()
}
