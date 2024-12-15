//
//  StoreMenuInteractor.swift
//  Products
//
//  Created by Mikhail Bereberdin on 04.12.2024.
//

import Foundation

import UIKit.UIImage

import Alamofire

/// ``IStoreMenuInteractor``.
public final class StoreMenuInteractor: IStoreMenuInteractor {
    
    // MARK: - Fields
    
    /// ``IStoresService``.
    private let _storesService: IStoresService
    
    /// Идентификатор магазина.
    private var _storeId: Int!
    
    public var positions: [StorePositionDto]
    
    public var mappedPositions: [(id: Int, name: String, price: Int, image: UIImage)]
    
    public private(set) var cart: [Int: Int]
    
    public weak var presenter: IStoreMenuPresenter!
    
    // MARK: - Inits
    
    /// ``IStoreMenuInteractor``.
    ///
    /// - Parameter presenter: ``IStoreMenuPresenter``.
    /// - Parameter StoresService: ``IStoresService``.
    public init(presenter: IStoreMenuPresenter, StoresService: IStoresService = MockStoresService()) {
        self._storesService = StoresService
        self.presenter = presenter
        
        self.positions = []
        self.mappedPositions = []
        self.cart = [:]
    }
    
    // MARK: - Methods
    
    public func setStoreId(_ id: Int) {
        self._storeId = id
    }
    
    public func setCart(_ cart: [Int: Int]) {
        self.cart = cart
    }
    
    public func loadStorePositionsAsync() async throws {
        self.positions = try await _storesService.getStorePositionsAsync(id: self._storeId)
    }
    
    public func mapStoreImagesAsync() async throws {
        self.mappedPositions = []
        
        for position in self.positions {
            let imageData = try await AF.request(position.imageURL, method: .get)
                .validate()
                .serializingData()
                .value
            
            let image = UIImage(data: imageData) ?? UIImage()
            let mappedPosition = (id: position.id, name: position.name, price: position.price, image: image)
            
            self.mappedPositions.append(mappedPosition)
        }
    }
    
    public func setPositionCount(positionId: Int, count: Int) {
        self.cart[positionId] = count == 0 ? nil : count
    }
}
