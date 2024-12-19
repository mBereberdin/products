//
//  NearestStoresAssembler.swift
//  Products
//
//  Created by Mikhail Bereberdin on 20.11.2024.
//

import Foundation

/// ``INearestStoresAssembler``.
public final class NearestStoresAssembler: INearestStoresAssembler {
    
    // MARK: - Methods
    
    public func assemble(with view: any INearestStoresView) {
        let presenter = NearestStoresPresenter(view: view)
        let interactor = NearestStoresInteractor(presenter: presenter)
        let router = NearestStoresRouter(view: view)
        
        view.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
