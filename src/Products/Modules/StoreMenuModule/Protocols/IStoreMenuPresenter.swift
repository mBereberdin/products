//
//  IStoreMenuPresenter.swift
//  Products
//
//  Created by Mikhail Bereberdin on 04.12.2024.
//

import Foundation

import UIKit.UICollectionViewCell

/// Презентер меню магазина.
///
/// Получает от View информацию о действиях пользователя и преображает ее в запросы к Router’у,
/// Interactor’у, а также получает данные от Interactor’a, подготавливает их и отправляет View для отображения.
public protocol IStoreMenuPresenter: AnyObject {
    
    // MARK: - Fields
    
    /// ``IStoreMenuView``.
    var view: IStoreMenuView! { get set }
    
    /// ``IStoreMenuInteractor``.
    var interactor: IStoreMenuInteractor! { get set }
    
    /// ``IStoreMenuRouter``.
    var router: IStoreMenuRouter! { get set }
    
    // MARK: - Methods
    
    /// Представление было загружено.
    func viewDidLoad()
    
    /// Предоставить идентификатор магазина.
    ///
    /// - Parameter id: Идентификатор магазина.
    func provideStoreId(_ id: Int)
    
    /// Предоставить корзину.
    ///
    /// - Parameter cart: Корзина.
    func provideCart(_ cart: [StorePositionDto: Int])
    
    /// Получить количество элементов в секции.
    ///
    /// - Returns: Колличество элементов в секции.
    func getNumberOfItemsInSection() -> Int
    
    /// Получить ячейку для элемента.
    ///
    /// - Parameter collectionView: Представление коллекции, для которого необходимо предоставить ячейку.
    /// - Parameter indexPath: Путь ячейки.
    ///
    /// - Returns: Ячейка для элемента.
    func getCellForItem(for collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell
    
    /// Обработка нажатия на кнопку оплаты.
    func onPaymentButtonTapped()
}
