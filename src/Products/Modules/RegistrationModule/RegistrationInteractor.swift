//
//  RegistrationInteractor.swift
//  Products
//
//  Created by Mikhail Bereberdin on 13.11.2024.
//

import Foundation

/// ``IRegistrationInteractor``.
public final class RegistrationInteractor: IRegistrationInteractor {
    
    // MARK: - Fields
    
    /// ``IRegistrationService``.
    private let _registrationService: IRegistrationService
    
    public weak var presenter: IRegistrationPresenter!
    
    // MARK: - Inits
    
    /// ``IRegistrationInteractor``.
    ///
    /// - Parameters:
    ///   - presenter: ``IRegistrationPresenter``.
    ///   - registrationService: ``IRegistrationService``.
    public init(presenter: IRegistrationPresenter, registrationService: IRegistrationService = MockRegistrationService()) {
        self.presenter = presenter
        self._registrationService = registrationService
    }
    
    // MARK: - Methods
    
    public func validatePassword(_ password: String) -> Bool {
        if password.count < 6 {
            return false
        }
        
        var hasUpper = false
        var hasLower = false
        var hasNumber = false
        
        for character in password {
            if !hasUpper && character.isLetter && character.isUppercase {
                hasUpper = true
            }
            
            if !hasLower && character.isLetter && character.isLowercase {
                hasLower = true
            }
            
            if !hasNumber && character.isNumber {
                hasNumber = true
            }
        }
        
        let isValid = hasUpper && hasLower && hasNumber
        
        return isValid
    }
    
    public func comparePasswords(_ firstPassword: String, _ secondPassword: String) -> Bool {
        let areEqual = firstPassword == secondPassword
        
        return areEqual
    }
    
    public func registerUserAsync(email: String, password: String) async throws {
        let registrationDto = LoginDataDto(login: email, password: password)
        try await _registrationService.sendRegisterRequestAsync(loginData: registrationDto)
    }
}
