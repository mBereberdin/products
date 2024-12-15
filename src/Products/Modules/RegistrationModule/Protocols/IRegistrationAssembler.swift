//
//  IRegistrationAssembler.swift
//  Products
//
//  Created by Mikhail Bereberdin on 13.11.2024.
//

import Foundation

/// Сборка модуля регистрации.
///
/// Знает о всех зависимостях внутри модуля.
public protocol IRegistrationAssembler: AnyObject {
    
    /// Собрать модуль для представления.
    ///
    /// - Parameter view: Представление, для которого необходимо собрать модуль.
    func assemble(with view: IRegistrationView)
}
