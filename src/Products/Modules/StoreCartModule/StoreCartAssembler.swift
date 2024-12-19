//
//  StoreCartAssembler.swift
//  Products
//
//  Created by Mikhail Bereberdin on 09.12.2024.
//

import Foundation

/// ``IStoreCartAssembler``.
public final class StoreCartAssembler: IStoreCartAssembler {
    
    // MARK: - Methods
    
    public func assemble(with view: IStoreCartView) {
        let presenter = StoreCartPresenter(view: view)
        let interactor = StoreCartInteractor(presenter: presenter)
        
        view.presenter = presenter
        presenter.interactor = interactor
    }
}
