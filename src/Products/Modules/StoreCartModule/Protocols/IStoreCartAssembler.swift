//
//  IStoreCartAssembler.swift
//  Products
//
//  Created by Mikhail Bereberdin on 09.12.2024.
//

import Foundation

/// Сборка модуля корзины магазина.
///
/// Знает о всех зависимостях внутри модуля.
public protocol IStoreCartAssembler: AnyObject {
    
    /// Собрать модуль для представления.
    ///
    /// - Parameter view: Представление, для которого необходимо собрать модуль.
    func assemble(with view: IStoreCartView)
}
