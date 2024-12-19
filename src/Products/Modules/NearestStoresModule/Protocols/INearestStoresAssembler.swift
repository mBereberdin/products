//
//  INearestStoresAssembler.swift
//  Products
//
//  Created by Mikhail Bereberdin on 20.11.2024.
//

import Foundation

/// Сборка модуля ближайших магазинов.
///
/// Знает о всех зависимостях внутри модуля.
public protocol INearestStoresAssembler: AnyObject {
    
    /// Собрать модуль для представления.
    ///
    /// - Parameter view: Представление, для которого необходимо собрать модуль.
    func assemble(with view: INearestStoresView)
}
