//
//  IStoreMenuAssembler.swift
//  Products
//
//  Created by Mikhail Bereberdin on 04.12.2024.
//

import Foundation

/// Сборка модуля меню магазина.
///
/// Знает о всех зависимостях внутри модуля.
public protocol IStoreMenuAssembler: AnyObject {
    
    /// Собрать модуль для представления.
    ///
    /// - Parameter view: Представление, для которого необходимо собрать модуль.
    func assemble(with view: IStoreMenuView)
}
