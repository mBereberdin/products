//
//  PStepper.swift
//  Products
//
//  Created by Mikhail Bereberdin on 03.12.2024.
//

import UIKit

/// Степпер приложения.
public final class PStepper: UIControl {
    
    // MARK: - UI
    
    /// Стэк представление.
    private var stackView: UIStackView!
    
    /// Кнопка понижения значения.
    private var decrementButton: UIButton!
    
    /// Надпись значения.
    private var valueLabel: UILabel!
    
    /// Кнопка повышения значения.
    private var incrementButton: UIButton!
    
    // MARK: - Fields
    
    /// Значение степпера.
    private var _value: Int {
        didSet {
            self.valueLabel.text = String(self._value)
            
            if let subscriber = self.onValueChanged {
                subscriber(self._value)
            }
        }
    }
    
    /// Обработка изменения значения.
    public var onValueChanged: ((Int) -> ())?
    
    // MARK: - Inits
    
    /// ``PStepper``.
    ///
    /// - Parameter frame: Прямоугольник кадра для представления.
    public override init(frame: CGRect) {
        self._value = 0
        
        super.init(frame: frame)
        
        self.configureUI()
    }
    
    /// ``PStepper``.
    ///
    /// - Parameter coder: Кодировщик.
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    /// Получить значение.
    ///
    /// - Returns: Текущее значение степпера.
    public func getValue() -> Int {
        return _value
    }
    
    /// Установить значение.
    ///
    /// - Parameter value: Значение.
    public func setValue(_ value: Int) {
        self._value = value
    }
    
    // MARK: - Configure ui external methods
    
    /// Установить цвет кнопок.
    ///
    /// - Parameter color: Цвет.
    public func setButtonsColor(_ color: UIColor) {
        self.incrementButton.imageView?.tintColor = color
        self.decrementButton.imageView?.tintColor = color
    }
    
    // MARK: - Private
    
    /// Увеличить значение.
    @objc private func incrementValue() {
        _value += 1
    }
    
    /// Уменьшить значение.
    @objc private func decrementValue() {
        if _value == 0 {
            return
        }
        
        _value -= 1
    }
}

// MARK: - Configure ui extensions
extension PStepper {
    
    /// Настроить ui.
    private func configureUI() {
        self.configureView()
        self.configureStackView()
        
        self.configureDecrementButton()
        self.configureValueLabel()
        self.configureIncrementButton()
    }
    
    /// Настроить представление.
    private func configureView() {
        self.backgroundColor = .clear
    }
    
    /// Настроить стэк представление.
    private func configureStackView() {
        self.stackView = UIStackView()
        
        self.addSubview(self.stackView)
        
        self.stackView.snp.makeConstraints { make in
            make.directionalEdges.equalToSuperview()
        }
        
        self.stackView.axis = .horizontal
        self.stackView.spacing = 9
        self.stackView.distribution = .equalSpacing
        self.stackView.alignment = .center
    }
    
    /// Настроить кнопку понижения значения.
    private func configureDecrementButton() {
        self.decrementButton = UIButton()
        
        self.stackView.addArrangedSubview(self.decrementButton)
        
        self.decrementButton.setImage(UIImage(systemName: "minus"), for: .normal)
        self.decrementButton.imageView?.tintColor = UIColor(hexString: "#7ADB60")
        self.decrementButton.addTarget(self, action: #selector(self.decrementValue), for: .touchUpInside)
    }
    
    /// Настроить надпись значения.
    private func configureValueLabel() {
        self.valueLabel = UILabel()
        
        self.stackView.addArrangedSubview(self.valueLabel)
        
        self.valueLabel.numberOfLines = 1
        self.valueLabel.textAlignment = .center
        self.valueLabel.font = .systemFont(ofSize: 14, weight: .regular)
        self.valueLabel.textColor = Constants.textColor
        self.valueLabel.text = "0"
    }
    
    /// Настроить кнопку повышения значения.
    private func configureIncrementButton() {
        self.incrementButton = UIButton()
        
        self.stackView.addArrangedSubview(self.incrementButton)
        
        self.incrementButton.setImage(UIImage(systemName: "plus"), for: .normal)
        self.incrementButton.imageView?.tintColor = UIColor(hexString: "#7ADB60")
        self.incrementButton.addTarget(self, action: #selector(self.incrementValue), for: .touchUpInside)
    }
}
