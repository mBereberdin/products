//
//  LoginRouter.swift
//  Products
//
//  Created by Mikhail Bereberdin on 17.11.2024.
//

import Foundation

/// ``ILoginRouter``.
public final class LoginRouter: @preconcurrency ILoginRouter {
    
    // MARK: - Fields
    
    /// ``ILoginView``.
    public weak var view: ILoginView!
    
    // MARK: - Inits
    
    /// ``ILoginRouter``.
    ///
    /// - Parameter view: ``ILoginView``.
    public init(view: ILoginView) {
        self.view = view
    }
    
    // MARK: - Methods
    
    @MainActor public func showNearestStoresView() {
        let nearestStoresView = NearestStoresView()
        self.view.showNearestStoresView(nearestStoresView, animated: true)
    }
}
