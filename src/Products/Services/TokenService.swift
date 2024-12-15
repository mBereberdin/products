//
//  TokenService.swift
//  Products
//
//  Created by Mikhail Bereberdin on 18.11.2024.
//

import Foundation

/// ``ITokenService``.
public final class TokenService: ITokenService {
    
    // MARK: - Fields
    
    /// ``LoginDataDto``.
    private var _loginData: LoginDataDto?
    
    public nonisolated(unsafe) static var shared: ITokenService!
    
    public var currentToken: TokenDto
    
    // MARK: - Inits
    
    /// ``ITokenService``.
    ///
    /// - Parameters:
    ///   - loginData: ``LoginDataDto``.
    ///   - token: Текущий токен пользователя.
    public init(loginData: LoginDataDto, token: TokenDto) {
        self._loginData = loginData
        self.currentToken = token
        
        TokenService.shared = self
    }
}
