//
//  StoreMenuRouter.swift
//  Products
//
//  Created by Mikhail Bereberdin on 04.12.2024.
//

import Foundation

/// ``IStoreMenuRouter``.
public final class StoreMenuRouter: @preconcurrency IStoreMenuRouter {
    
    // MARK: - Fields
    
    public weak var view: IStoreMenuView!
    
    // MARK: - Inits
    
    /// ``IStoreMenuRouter``.
    ///
    /// - Parameter view: ``IStoreMenuView``.
    public init(view: IStoreMenuView) {
        self.view = view
    }
    
    // MARK: - Methods
    
    @MainActor public func showStoreCartView(with cart: [StorePositionDto : Int]) {
        let storeCartView = StoreCartView()
        storeCartView.provideCart(cart)
        
        view.showStoreCartView(storeCartView)
    }
}
