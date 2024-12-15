//
//  LoginPresenter.swift
//  Products
//
//  Created by Mikhail Bereberdin on 17.11.2024.
//

import Foundation

/// ``ILoginPresenter``.
public final class LoginPresenter: @preconcurrency ILoginPresenter {
    
    // MARK: - Fields
    
    /// ``ILoginView``.
    public weak var view: ILoginView!
    
    /// ``ILoginInteractor``.
    public var interactor: ILoginInteractor!
    
    /// ``ILoginRouter``.
    public var router: ILoginRouter!
    
    // MARK: - Inits
    
    /// ``ILoginPresenter``.
    ///
    /// - Parameter view: ``ILoginView``.
    public init(view: ILoginView) {
        self.view = view
    }
    
    // MARK: - Methods
    
    public func viewTapped() {
        view.hideKeyboard()
    }
    
    public func viewDidLoad() {
        view.configureUI()
        view.addViewTapRecognizer()
    }
    
    @MainActor
    public func loginButtonTapped() {
        guard let email = view.getEmailValue() else {
            view.showAlert(description: "Не заполнено поле \"e-mail\".")
            
            return
        }
        
        guard let password = view.getPasswordValue() else {
            view.showAlert(description: "Не заполнено поле \"Пароль\".")
            
            return
        }
        
        Task {
            do {
                try await interactor.loginUserAsync(email: email, password: password)
            } catch let error {
                view.showAlert(description: error.localizedDescription)
                
                return
            }
            
            router.showNearestStoresView()
        }
    }
}
