//
//  NearestStoresMapAssembler.swift
//  Products
//
//  Created by Mikhail Bereberdin on 02.12.2024.
//

import Foundation

/// ``INearestStoresMapAssembler``.
public final class NearestStoresMapAssembler: INearestStoresMapAssembler {
    
    // MARK: - Methods
    
    public func assemble(with view: INearestStoresMapView) {
        let presenter = NearestStoresMapPresenter(view: view)
        let interactor = NearestStoresMapInteractor(presenter: presenter)
        let router = NearestStoresMapRouter(view: view)
        
        view.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
