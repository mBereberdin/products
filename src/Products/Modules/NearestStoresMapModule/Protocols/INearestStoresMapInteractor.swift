//
//  INearestStoresMapInteractor.swift
//  Products
//
//  Created by Mikhail Bereberdin on 02.12.2024.
//

import Foundation

/// Интерактор карты ближайших магазинов.
///
/// Содержит всю бизнес-логику, необходимую для работы текущего модуля.
public protocol INearestStoresMapInteractor: AnyObject {
    
    // MARK: - Fields
    
    /// ``INearestStoresPresenter``.
    var presenter: INearestStoresMapPresenter! { get set }
    
    /// Магазины.
    var stores: [StoreDto] { get }
    
    // MARK: - Methods
    
    /// Установить магазины.
    ///
    /// - Parameter stores: Магазины.
    func setStores(_ stores: [StoreDto])
}
