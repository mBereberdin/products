//
//  StoresService.swift
//  Products
//
//  Created by Mikhail Bereberdin on 20.11.2024.
//

import Foundation

import Alamofire

/// ``IStoresService``.
public struct StoresService: IStoresService {
    
    // MARK: - Fields
    
    /// ``ITokenService``.
    private let _tokenService: ITokenService
    
    /// Заголовки запросов к контроллеру магазинов.
    private let HEADERS: HTTPHeaders = [
        .accept("application/json")
    ]
    
    // MARK: - Inits
    
    /// ``IStoresService``.
    ///
    /// - Parameter tokenService: ``ITokenService``.
    public init(tokenService: ITokenService = TokenService.shared) {
        _tokenService = tokenService
    }
    
    // MARK: - Methods
    
    public func getStoresAsync() async throws -> [StoreDto] {
        let actualToken = _tokenService.currentToken.token
        var requestHeaders = HEADERS
        requestHeaders.add(.authorization(bearerToken: actualToken))
        
        let stores = try await AF.request(APIs.store.stores.locations.url, method: .get, headers: requestHeaders)
            .validate()
            .serializingDecodable([StoreDto].self)
            .value
        
        return stores
    }
    
    public func getStorePositionsAsync(id: Int) async throws -> [StorePositionDto] {
        let actualToken = _tokenService.currentToken.token
        var requestHeaders = HEADERS
        requestHeaders.add(.authorization(bearerToken: actualToken))
        
        let positions = try await AF.request(APIs.store.stores.menu(id: id).url, method: .get, headers: requestHeaders)
            .validate()
            .serializingDecodable([StorePositionDto].self)
            .value
        
        return positions
    }
}
