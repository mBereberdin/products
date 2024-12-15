//
//  PTextField.swift
//  Products
//
//  Created by Mikhail Bereberdin on 12.11.2024.
//

import Foundation
import UIKit.UITextField

/// Текстовое поле приложения.
public final class PTextField: UITextField {
    
    // MARK: - Fields
    
    /// Внутренняя рамка для текста.
    private let textInset = UIEdgeInsets(top: 13, left: 18, bottom: 13, right: 20)
    
    // MARK: - Methods
    
    /// Рамка для текста.
    ///
    /// - Parameter bounds: Границы объекта.
    ///
    /// - Returns: Рамка для текста.
    public override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textInset)
    }
    
    /// Рамка для текста-заглушки.
    ///
    /// - Parameter bounds: Границы объекта.
    ///
    /// - Returns: Рамка для текста-заглушки.
    public override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textInset)
    }
    
    /// Рамка для редактирования текста.
    ///
    /// - Parameter bounds: Границы объекта.
    ///
    /// - Returns: Рамка для для редактирования текста.
    public override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textInset)
    }
}
