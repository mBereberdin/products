//
//  LoginInteractor.swift
//  Products
//
//  Created by Mikhail Bereberdin on 17.11.2024.
//

import Foundation

/// ``ILoginInteractor``.
public final class LoginInteractor: ILoginInteractor {
    
    // MARK: - Fields
    
    /// ``IRegistrationService``.
    private var _registrationService: IRegistrationService
    
    /// ``ILoginPresenter``.
    public weak var presenter: ILoginPresenter!
    
    // MARK: - Inits
    
    /// ``ILoginInteractor``.
    ///
    /// - Parameter presenter: ``ILoginPresenter``.
    public init(presenter: ILoginPresenter, registrationService: IRegistrationService = MockRegistrationService()) {
        self.presenter = presenter
        self._registrationService = registrationService
    }
    
    // MARK: - Methods
    
    public func loginUserAsync(email: String, password: String) async throws {
        let loginDataDto = LoginDataDto(login: email, password: password)
        let token = try await _registrationService.sendLoginRequestAsync(loginData: loginDataDto)
        _ = TokenService(loginData: loginDataDto, token: token)
    }
}
