//
//  ILoginAssembler.swift
//  Products
//
//  Created by Mikhail Bereberdin on 15.11.2024.
//

import Foundation

/// Сборка модуля авторизации.
///
/// Знает о всех зависимостях внутри модуля.
public protocol ILoginAssembler: AnyObject {
    
    /// Собрать модуль для представления.
    ///
    /// - Parameter view: Представление, для которого необходимо собрать модуль.
    func assemble(with view: ILoginView)
}
