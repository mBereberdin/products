//
//  PNamedTextFieldView.swift
//  Products
//
//  Created by Mikhail Bereberdin on 09.11.2024.
//

import UIKit

import SnapKit

/// Представление именованного текстового поля.
public final class PNamedTextFieldView: UIView {
    
    // MARK: - UI
    
    /// Надпись текстового поля.
    private var textFieldLabel: UILabel!
    
    /// Текстовое поле.
    private var textField: UITextField!
    
    // MARK: - Fields
    
    /// Атрибуты текста-заглушки.
    private let PLACEHOLDER_TEXT_ATTRIBUTES: [NSAttributedString.Key: Any] = [
        .foregroundColor: Constants.placeHolderColor,
        .font: UIFont.systemFont(ofSize: 18, weight: .regular)
    ]
    
    // MARK: - Inits
    
    /// ``PNamedTextFieldView``.
    ///
    /// - Parameter frame: Рамка для представления.
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    /// ``PNamedTextFieldView``.
    ///
    /// - Parameter coder: Кодировщик.
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    /// Установить наименование текстового поля.
    ///
    /// - Parameter name: Наименование, которое необходимо установить.
    public func setName(_ name: String) {
        self.textFieldLabel.text = name
    }
    
    /// Установить значение текста заглушки текстового поля.
    ///
    /// - Parameter placeholderText: Значение текста заглушки.
    public func setTextFieldPlaceholder(_ placeholderText: String) {
        self.textField.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: self.PLACEHOLDER_TEXT_ATTRIBUTES)
    }
    
    /// Устнановить тип содержимого текстового поля.
    ///
    /// - Parameter type: Тип содержимого текстового поля.
    public func setTextFieldType(_ type: UITextContentType) {
        self.textField.textContentType = type
        if type == .password || type == .newPassword {
            self.textField.isSecureTextEntry = true
        }
    }
    
    /// Получить значение текстового поля.
    ///
    /// - Returns: Значение текстового поля.
    public func getTextFieldValue() -> String? {
        return self.textField.text?.isEmpty == true ? nil : self.textField.text
    }
}

// MARK: - Configure UI extensions
extension PNamedTextFieldView {
    
    /// Настроить ui.
    private func configureUI() {
        self.isUserInteractionEnabled = true
        configureTextFieldLabel()
        configureTextField()
    }
    
    /// Настроить надпись текстового поля.
    private func configureTextFieldLabel() {
        self.textFieldLabel = UILabel()
        
        self.addSubview(textFieldLabel)
        
        self.textFieldLabel.snp.makeConstraints { make in
            make.height.equalTo(18)
            make.width.equalToSuperview()
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
        }
        
        self.textFieldLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        self.textFieldLabel.textColor = Constants.textColor
    }
    
    /// Настроить текстовое поле.
    private func configureTextField() {
        self.textField = PTextField()
        
        self.addSubview(textField)
        
        self.textField.delegate = self
        
        self.textField.autocorrectionType = .no
        self.textField.returnKeyType = .done
        
        self.textField.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(48)
            make.top.equalTo(self.textFieldLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview()
        }
        
        self.textField.layer.cornerRadius = 24.5
        self.textField.layer.borderWidth = 2
        self.textField.layer.borderColor = Constants.textColor.cgColor
        
        self.textField.textColor = Constants.textColor
        self.textField.font = UIFont.systemFont(ofSize: 18, weight: .regular)
    }
}

// MARK: - UITextFieldDelegate extensions
extension PNamedTextFieldView: UITextFieldDelegate {
    
    /// Нужно ли обрабатывать нажатие кнопки «Возврат» для текстового поля.
    ///
    /// - Parameter textField: Текстовое поле, кнопка возврата которого была нажата.
    ///
    /// - Returns: True, если текстовое поле должно реализовать свое поведение по умолчанию для кнопки возврата; иначе - false.
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        
        return false
    }
}
