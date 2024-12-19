//
//  IStoreCartInteractor.swift
//  Products
//
//  Created by Mikhail Bereberdin on 09.12.2024.
//

import Foundation

/// Интерактор корзины магазина.
///
/// Содержит всю бизнес-логику, необходимую для работы текущего модуля.
public protocol IStoreCartInteractor: AnyObject {
    
    // MARK: - Fields
    
    /// ``IStoreCartPresenter``.
    var presenter: IStoreCartPresenter! { get set }
    
    /// Корзина.
    var cart: [StorePositionDto: Int] { get }
    
    // MARK: - Methods
    
    /// Установить значение количества позиции.
    ///
    /// - Parameters:
    ///   - positionId: Идентификатор позиции.
    ///   - count: Количество.
    func setPositionCount(positionId: Int, count: Int)
    
    /// Установить значение корзины.
    ///
    /// - Parameter cart: Корзина.
    func setCart(_ cart: [StorePositionDto: Int])
    
    /// Получить позицию.
    ///
    /// - Parameter index: Индекс позиции.
    ///
    /// - Returns: Кортеж с информацией о позиции и ее кол-вом в корзине.
    func getPosition(at index: Int) -> (info: StorePositionDto, count: Int)
}
