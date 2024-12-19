//
//  NearestStoresMapInteractor.swift
//  Products
//
//  Created by Mikhail Bereberdin on 02.12.2024.
//

import Foundation

/// ``INearestStoresMapInteractor``.
public final class NearestStoresMapInteractor: INearestStoresMapInteractor {
    
    // MARK: - Fields
    
    public weak var presenter: INearestStoresMapPresenter!
    
    public var stores: [StoreDto]
    
    // MARK: - Inits
    
    /// ``INearestStoresMapInteractor``.
    ///
    /// - Parameter presenter: ``INearestStoresMapPresenter``.
    public init(presenter: INearestStoresMapPresenter) {
        self.presenter = presenter
        self.stores = []
    }
    
    // MARK: - Methods
    
    public func setStores(_ stores: [StoreDto]) {
        self.stores = stores
    }
}
