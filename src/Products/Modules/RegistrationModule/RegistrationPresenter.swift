//
//  RegistrationPresenter.swift
//  Products
//
//  Created by Mikhail Bereberdin on 13.11.2024.
//

import Foundation

/// ``IRegistrationPresenter``.
public final class RegistrationPresenter: @preconcurrency IRegistrationPresenter {
    
    // MARK: - Fields
    
    public weak var view: IRegistrationView!
    
    public var interactor: IRegistrationInteractor!
    
    public var router: IRegistrationRouter!
    
    // MARK: - Inits
    
    /// ``IRegistrationPresenter``.
    ///
    /// - Parameter view: ``IRegistrationView``.
    public init(view: IRegistrationView) {
        self.view = view
    }
    
    // MARK: - Methods
    
    @MainActor
    public func registerButtonTapped() {
        guard let email = view.getEmailValue() else {
            view.showAlert(description: "Поле \"e-mail\" не заполнено.")
            
            return
        }
        
        // TODO: Валидация e-mail.
        
        guard let password = view.getPasswordValue(),
              let confirmPassword = view.getConfirmPasswordValue() else {
            view.showAlert(description: "Не заполнено одно из полей пароля.")
            
            return
        }
        
        let isPasswordValid = interactor.validatePassword(password)
        if !isPasswordValid {
            // TODO: Добавить кнопку с информацией для отображения требований пароля.
            view.showAlert(description: "Пароль не удовлетворяет минимальным требованиям.")
            
            return
        }
        
        let arePasswordsEqual = interactor.comparePasswords(password, confirmPassword)
        if !arePasswordsEqual {
            view.showAlert(description: "Пароли не совпадают.")
            
            return
        }
        
        Task {
            do {
                try await interactor.registerUserAsync(email: email, password: password)
            } catch let error {
                // TODO: добавить отображение читабельной ошибки от сервера.
                view.showAlert(description: "Не удалось зарегистрировать пользователя.\n\(error.localizedDescription)")
                
                return
            }
            
            router.showLoginView()
        }
    }
    
    public func viewTapped() {
        view.hideKeyboard()
    }
    
    public func viewDidLoad() {
        view.configureUI()
        view.addViewTapRecognizer()
    }
    
    public func viewDidLayoutSubviews() {
        view.configureShadows()
    }
}
