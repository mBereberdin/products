//
//  LoginAssembler.swift
//  Products
//
//  Created by Mikhail Bereberdin on 17.11.2024.
//

import Foundation

/// ``ILoginAssembler``.
public final class LoginAssembler: ILoginAssembler {
    
    // MARK: - Methods
    
    public func assemble(with view: ILoginView) {
        let presenter = LoginPresenter(view: view)
        let interactor = LoginInteractor(presenter: presenter)
        let router = LoginRouter(view: view)
        
        view.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
