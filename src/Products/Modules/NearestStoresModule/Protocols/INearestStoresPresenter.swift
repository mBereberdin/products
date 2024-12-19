//
//  INearestStoresPresenter.swift
//  Products
//
//  Created by Mikhail Bereberdin on 20.11.2024.
//

import Foundation

/// Презентер ближайших магазинов.
///
/// Получает от View информацию о действиях пользователя и преображает ее в запросы к Router’у,
/// Interactor’у, а также получает данные от Interactor’a, подготавливает их и отправляет View для отображения.
public protocol INearestStoresPresenter: AnyObject {
    
    // MARK: - Fields
    
    /// ``INearestStoresView``.
    var view: INearestStoresView! { get set }
    
    /// ``INearestStoresInteractor``.
    var interactor: INearestStoresInteractor! { get set }
    
    /// ``INearestStoresRouter``.
    var router: INearestStoresRouter! { get set }
    
    // MARK: - Methods
    
    /// Кнопка "На карте" была нажата.
    func onMapButtonTapped()
    
    /// Представление было загружено.
    func viewDidLoad()
    
    /// Получить количество строк.
    ///
    /// - Returns: Колличество строк.
    func getRowsCount() -> Int
    
    /// Установить информациию ячейки.
    ///
    /// - Parameter row: Строка ячейки.
    func setCellData(at row: Int)
    
    /// Была нажата ячейка.
    ///
    /// - Parameter row: Строка нажатой ячейки.
    func didSelectRow(_ row: Int)
}
