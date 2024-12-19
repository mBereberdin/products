//
//  INearestStoresView.swift
//  Products
//
//  Created by Mikhail Bereberdin on 19.11.2024.
//

import Foundation

/// Представление ближайших магазинов.
public protocol INearestStoresView: AnyObject {
    
    // MARK: - Fields
    
    /// ``INearestStoresPresenter``.
    var presenter: INearestStoresPresenter! { get set }
    
    /// ``INearestStoresAssembler``.
    var assembler: INearestStoresAssembler { get }
    
    // MARK: - Methods
    
    /// Настроить ui.
    func configureUI()
    
    /// Перезагрузить таблицу.
    func reloadTable()
    
    /// Показать предупреждение.
    ///
    /// - Parameters:
    ///   - title: Заголовок.
    ///   - description: Описание.
    func showAlert(title: String, description: String)
    
    /// Установить информацию ячейки.
    ///
    /// - Parameters:
    ///   - cellRow: Строка ячейки.
    ///   - cellInfo: Информация ячейки, которую необходимо установить.
    func setUpCellInfo(at cellRow: Int, with cellInfo: (title: String, subtitle: String))
    
    /// Показать представление ближайших магазинов на карте.
    ///
    /// - Parameter showNearestStoresMapView: ``INearestStoresMapView``.
    func showNearestStoresMapView(_ showNearestStoresMapView: INearestStoresMapView)
    
    /// Показать представление меню магазина.
    ///
    /// - Parameter showStoreMenuView: ``IStoreMenuView``.
    func showStoreMenuView(_ showStoreMenuView: IStoreMenuView)
}
