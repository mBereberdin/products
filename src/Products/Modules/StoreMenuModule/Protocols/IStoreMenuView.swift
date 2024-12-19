//
//  IStoreMenuView.swift
//  Products
//
//  Created by Mikhail Bereberdin on 02.12.2024.
//

import Foundation

/// Представление меню магазина.
///
/// Отвечает за отображение данных на экране и оповещает Presenter о действиях пользователя.
/// Пассивен, сам никогда не запрашивает данные, только получает их от презентера.
public protocol IStoreMenuView: AnyObject {
    
    // MARK: - Fields
    
    /// ``IStoreMenuPresenter``.
    var presenter: IStoreMenuPresenter! { get set }
    
    /// ``IStoreMenuAssembler``.
    var assembler: IStoreMenuAssembler { get }
    
    // MARK: - Methods
    
    /// Настроить ui.
    func configureUI()
    
    /// Перезагрузить сетку позиций.
    func reloadPositionsGrid()
    
    /// Перезагрузить видимые позиции.
    func reloadVisiblePositions()
    
    /// Предоставить идентификатор магазина.
    ///
    /// - Parameter id: Идентификатор магазина.
    func provideStoreId(_ id: Int)
    
    /// Предоставить корзину.
    ///
    /// - Parameter cart: Корзина.
    func provideCart(_ cart: [StorePositionDto: Int])
    
    /// Показать представление корзины магазина.
    ///
    /// - Parameter view: ``IStoreCartView``.
    func showStoreCartView(_ view: IStoreCartView)
}
