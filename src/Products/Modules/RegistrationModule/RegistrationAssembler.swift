//
//  RegistrationAssembler.swift
//  Products
//
//  Created by Mikhail Bereberdin on 13.11.2024.
//

import Foundation

/// ``IRegistrationAssembler``.
public final class RegistrationAssembler: IRegistrationAssembler {
    
    // MARK: - Methods
    
    public func assemble(with view: IRegistrationView) {
        let presenter = RegistrationPresenter(view: view)
        let interactor = RegistrationInteractor(presenter: presenter)
        let router = RegistrationRouter(view: view)
        
        view.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
