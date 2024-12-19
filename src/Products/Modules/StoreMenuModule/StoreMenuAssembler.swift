//
//  StoreMenuAssembler.swift
//  Products
//
//  Created by Mikhail Bereberdin on 04.12.2024.
//

import Foundation

/// ``IStoreMenuAssembler``.
public final class StoreMenuAssembler: IStoreMenuAssembler {
    
    // MARK: - Methods
    
    public func assemble(with view: IStoreMenuView) {
        let presenter = StoreMenuPresenter(view: view)
        let interactor = StoreMenuInteractor(presenter: presenter)
        let router = StoreMenuRouter(view: view)
        
        view.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
