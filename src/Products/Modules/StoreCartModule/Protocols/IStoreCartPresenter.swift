//
//  IStoreCartPresenter.swift
//  Products
//
//  Created by Mikhail Bereberdin on 09.12.2024.
//

import Foundation

import UIKit.UITableView
import UIKit.UITableViewCell

/// Презентер корзины магазина.
///
/// Получает от View информацию о действиях пользователя и преображает ее в запросы к Router’у,
/// Interactor’у, а также получает данные от Interactor’a, подготавливает их и отправляет View для отображения.
public protocol IStoreCartPresenter: AnyObject {
    
    // MARK: - Fields
    
    /// ``IStoreCartView``.
    var view: IStoreCartView! { get set }
    
    /// ``IStoreCartInteractor``.
    var interactor: IStoreCartInteractor! { get set }
    
    // MARK: - Methods
    
    /// Представление было загружено.
    func viewDidLoad()
    
    /// Представление было показано.
    func viewDidAppear()
    
    /// Представление будет скрыто.
    func viewWillDisappear()
    
    /// Предоставить корзину.
    ///
    /// - Parameter cart: Корзина позиций.
    func provideCart(_ cart: [StorePositionDto: Int])
    
    /// Получить количество элементов в секции.
    ///
    /// - Returns: Количество элементов в секции.
    func getNumberOfItemsInSection() -> Int
    
    /// Получить ячейку для элемента.
    ///
    /// - Parameter tableView: Представление таблицы, для которого необходимо предоставить ячейку.
    /// - Parameter indexPath: Путь ячейки.
    ///
    /// - Returns: Ячейка для элемента.
    func getCellForItem(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell
}
