//
//  NearestStoresRouter.swift
//  Products
//
//  Created by Mikhail Bereberdin on 20.11.2024.
//

import Foundation

/// ``INearestStoresRouter``.
public final class NearestStoresRouter: @preconcurrency INearestStoresRouter {
    
    // MARK: - Fields
    
    public weak var view: INearestStoresView!
    
    // MARK: - Inits
    
    /// ``INearestStoresRouter``.
    ///
    /// - Parameter view: ``INearestStoresView``.
    public init(view: INearestStoresView) {
        self.view = view
    }
    
    // MARK: - Methods
    
    @MainActor public func showNearestStoresMapView(with stores: [StoreDto]) {
        let nearestStoresMapView = NearestStoresMapView()
        nearestStoresMapView.provideStores(stores)
        
        view.showNearestStoresMapView(nearestStoresMapView)
    }
    
    @MainActor public func showStoreMenuView(storeId: Int) {
        let storeMenuView = StoreMenuView()
        storeMenuView.provideStoreId(storeId)
        
        view.showStoreMenuView(storeMenuView)
    }
}
