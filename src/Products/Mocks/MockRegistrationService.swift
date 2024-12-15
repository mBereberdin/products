//
//  MockRegistrationService.swift
//  Products
//
//  Created by Mikhail Bereberdin on 15.12.2024.
//

import Foundation

/// Мок сервиса регистрации.
public struct MockRegistrationService: IRegistrationService {
    
    // MARK: - Inits
    
    public init() {}
    
    // MARK: - Methods
    
    public func sendRegisterRequestAsync(loginData: LoginDataDto) async throws {
        // Не выкидываем исключение, поэтому считаем что регистрация прошла успешно.
    }
    
    public func sendLoginRequestAsync(loginData: LoginDataDto) async throws -> TokenDto {
        return TokenDto(token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJBdXRoZW50aWNhdGlvbiIsImlzcyI6InN0b3JlcyJ9.vU_pXNQGrFeymiB5Bo2nE09bhbdOMVXQYkuvphnOLUA", tokenLifetime: 3_600_000)
    }
}
