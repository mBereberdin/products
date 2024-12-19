//
//  RegistrationService.swift
//  Products
//
//  Created by Mikhail Bereberdin on 14.11.2024.
//

import Foundation

import Alamofire

/// ``IRegistrationService``.
public struct RegistrationService: IRegistrationService {
    
    // MARK: - Fields
    
    /// Заголовки запросов к контроллеру регистрации.
    private let HEADERS: HTTPHeaders = [
        "accept": "application/json",
        "Content-Type": "application/json",
    ]
    
    // MARK: - Inits
    
    /// ``IRegistrationService``.
    public init() { }
    
    // MARK: - Methods
    
    public func sendRegisterRequestAsync(loginData: LoginDataDto) async throws {
        try await withUnsafeThrowingContinuation { (continuation: UnsafeContinuation<Void, any Error>) in
            AF.request(APIs.store.auth.register.url, method: .post, parameters: loginData,
                       encoder: JSONParameterEncoder.sortedKeys, headers: HEADERS)
            .validate()
            .responseData { response in
                if let error = response.error {
                    // TODO: По хорошему стоит завести enum ошибок для конвертации ответов >299 и с override localizedDescription
                    // чтобы прокидывать их выше и показывать локализованую user-friendly ошибку.
                    continuation.resume(throwing: error)
                    
                    return
                }
                
                continuation.resume()
                
                return
            }
        }
    }
    
    public func sendLoginRequestAsync(loginData: LoginDataDto) async throws -> TokenDto {
        let token = try await AF.request(APIs.store.auth.login.url, method: .post, parameters: loginData, encoder: JSONParameterEncoder.sortedKeys, headers: HEADERS)
            .validate()
            .serializingDecodable(TokenDto.self)
            .value
        
        return token
    }
}
