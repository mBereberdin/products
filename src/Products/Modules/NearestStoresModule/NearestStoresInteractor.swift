//
//  NearestStoresInteractor.swift
//  Products
//
//  Created by Mikhail Bereberdin on 20.11.2024.
//

import Foundation

import CoreLocation

/// ``INearestStoresInteractor``.
public final class NearestStoresInteractor: INearestStoresInteractor {
    
    // MARK: - Fields
    
    /// ``IStoresService``.
    private let _storesService: IStoresService
    
    /// ``ILocationService``.
    private let _locationService: ILocationService
    
    public var stores: [StoreDto]
    
    public weak var presenter: INearestStoresPresenter!
    
    public var mappedStores: [(name: String, distance: Int)]
    
    // MARK: - Inits
    
    /// ``INearestStoresInteractor``.
    ///
    /// - Parameter presenter: ``INearestStoresPresenter``.
    /// - Parameter StoresService: ``IStoresService``.
    /// - Parameter locationService: ``LocationService``.
    public init(presenter: INearestStoresPresenter, StoresService: IStoresService = MockStoresService(),
                locationService: ILocationService = LocationService()
    ) {
        self.presenter = presenter
        self._storesService = StoresService
        self._locationService = locationService
        
        self.stores = []
        self.mappedStores = []
    }
    
    // MARK: - Methods
    
    public func loadStoresAsync() async throws {
        self.stores = try await _storesService.getStoresAsync()
    }
    
    public func calculateStoresDistanceAsync() async throws {
        mappedStores = []
        
        for store in self.stores {
            let name = store.name
            let distance = try await _locationService.getDistanceToUserAsync(latitude: store.location.latitude, longitude: store.location.longitude)
            mappedStores.append((name, distance))
        }
    }
}
