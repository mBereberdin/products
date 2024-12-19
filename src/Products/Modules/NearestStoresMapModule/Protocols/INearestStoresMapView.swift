//
//  INearestStoresMapView.swift
//  Products
//
//  Created by Mikhail Bereberdin on 26.11.2024.
//

import Foundation
import CoreLocation.CLLocation

/// Представление карты ближайших магазинов.
///
/// Отвечает за отображение данных на экране и оповещает Presenter о действиях пользователя.
/// Пассивен, сам никогда не запрашивает данные, только получает их от презентера.
public protocol INearestStoresMapView: AnyObject {
    
    // MARK: - Fields
    
    /// ``INearestStoresMapPresenter``.
    var presenter: INearestStoresMapPresenter! { get set }
    
    /// ``INearestStoresMapAssembler``.
    var assembler: INearestStoresMapAssembler { get }
    
    // MARK: - Methods
    
    /// Настроить ui.
    func configureUI()
    
    /// Предоставить магазины.
    ///
    /// - Parameter stores: Магазины, которые необходимо предоставить.
    func provideStores(_ stores: [StoreDto])
    
    /// Показать аннотации магазинов.
    ///
    /// - Parameter storeAnnotations: Аннотации магазинов, которые необходимо показать.
    func showStoreAnnotations(_ storeAnnotations: [PStoreAnnotation])
    
    /// Показать представление меню магазина.
    ///
    /// - Parameter view: ``IStoreMenuView``.
    func showStoreMenuView(_ view: IStoreMenuView)
}
