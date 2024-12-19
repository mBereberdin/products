//
//  NearestStoresMapRouter.swift
//  Products
//
//  Created by Mikhail Bereberdin on 02.12.2024.
//

import Foundation

/// ``INearestStoresMapRouter``.
public final class NearestStoresMapRouter: @preconcurrency INearestStoresMapRouter {
    
    // MARK: - Fields
    
    public weak var view: INearestStoresMapView!
    
    // MARK: - Inits
    
    /// ``INearestStoresMapRouter``.
    ///
    /// - Parameter view: ``INearestStoresMapView``.
    public init(view: INearestStoresMapView) {
        self.view = view
    }
    
    // MARK: - Methods
    
    @MainActor public func showStoreMenuView(storeId: Int) {
        let storeMenuView = StoreMenuView()
        storeMenuView.provideStoreId(storeId)
        
        self.view.showStoreMenuView(storeMenuView)
    }
}
