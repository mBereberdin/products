//
//  IStoreMenuInteractor.swift
//  Products
//
//  Created by Mikhail Bereberdin on 04.12.2024.
//

import Foundation

import UIKit.UIImage

/// Интерактор меню магазина.
///
/// Содержит всю бизнес-логику, необходимую для работы текущего модуля.
public protocol IStoreMenuInteractor: AnyObject {
    
    // MARK: - Fields
    
    /// ``IStoreMenuPresenter``.
    var presenter: IStoreMenuPresenter! { get set }
    
    /// Позиции магазина.
    var positions: [StorePositionDto] { get }
    
    /// Преобразованные позиции магазина.
    var mappedPositions: [(id: Int, name: String, price: Int, image: UIImage)] { get }
    
    /// Корзина.
    var cart: [Int: Int] { get }
    
    // MARK: - Methods
    
    /// Задать идентификатор магазина.
    ///
    /// - Parameter id: Идентификатор магазина.
    func setStoreId(_ id: Int)
    
    /// Установить значение корзины.
    ///
    /// - Parameter cart: Корзина.
    func setCart(_ cart: [Int: Int])
    
    /// Загрузить позиции магазина.
    func loadStorePositionsAsync() async throws
    
    /// Загрузить и преобразовать изображения позиций.
    func mapStoreImagesAsync() async throws
    
    /// Установить значение колличества позиции.
    ///
    /// - Parameters:
    ///   - positionId: Идентификатор позиции.
    ///   - count: Колличество.
    func setPositionCount(positionId: Int, count: Int)
}
