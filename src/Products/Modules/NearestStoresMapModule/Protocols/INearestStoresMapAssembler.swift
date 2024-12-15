//
//  INearestStoresMapAssembler.swift
//  Products
//
//  Created by Mikhail Bereberdin on 02.12.2024.
//

import Foundation

/// Сборка модуля карты ближайших магазинов.
///
/// Знает о всех зависимостях внутри модуля.
public protocol INearestStoresMapAssembler: AnyObject {
    
    /// Собрать модуль для представления.
    ///
    /// - Parameter view: Представление, для которого необходимо собрать модуль.
    func assemble(with view: INearestStoresMapView)
}
