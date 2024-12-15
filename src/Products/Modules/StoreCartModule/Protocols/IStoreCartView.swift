//
//  IStoreCartView.swift
//  Products
//
//  Created by Mikhail Bereberdin on 08.12.2024.
//

import Foundation

/// Представление корзины магазина.
///
/// Отвечает за отображение данных на экране и оповещает Presenter о действиях пользователя.
/// Пассивен, сам никогда не запрашивает данные, только получает их от презентера.
public protocol IStoreCartView: AnyObject {
    
    // MARK: - Fields
    
    /// ``IStoreCartPresenter``.
    var presenter: IStoreCartPresenter! { get set }
    
    /// ``IStoreCartAssembler``.
    var assembler: IStoreCartAssembler { get }
    
    // MARK: - Methods
    
    /// Настроить ui.
    func configureUI()
    
    /// Пролистать таблицу вверх.
    func scrollTableToUp()
    
    /// Предоставить корзину.
    ///
    /// - Parameter cart: Корзина.
    func provideCart(_ cart: [StorePositionDto: Int])
    
    /// Вернуть корзину.
    ///
    /// - Parameter cart: Корзина.
    func returnCart(_ cart: [StorePositionDto: Int])
    
    /// Удалить ячейку.
    ///
    /// - Parameter indexPath: Путь индекса, идентифицирующий ячейку для удаления.
    func removeCell(at indexPath: IndexPath)
}
