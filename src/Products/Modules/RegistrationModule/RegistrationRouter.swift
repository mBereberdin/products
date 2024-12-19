//
//  RegistrationRouter.swift
//  Products
//
//  Created by Mikhail Bereberdin on 13.11.2024.
//

import Foundation
import UIKit

/// ``IRegistrationRouter``.
public final class RegistrationRouter: @preconcurrency IRegistrationRouter {
    
    // MARK: - Fields
    
    public weak var view: IRegistrationView!
    
    // MARK: - Inits
    
    /// ``IRegistrationRouter``.
    ///
    /// - Parameter view: ``IRegistrationView``.
    public init(view: IRegistrationView) {
        self.view = view
    }
    
    // MARK: - Methods
    
    @MainActor public func showLoginView() {
        let loginView = LoginView()
        self.view.presentLoginView(loginView, animated: true)
    }
}
