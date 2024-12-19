//
//  PButton.swift
//  Products
//
//  Created by Mikhail Bereberdin on 09.11.2024.
//

import UIKit

/// Кнопка приложения.
public final class PButton: UIButton {
    
    // MARK: - Fields
    
    /// Слой тени.
    private var shadowLayer: CALayer!
    
    /// Фоновый слой.
    private var backgroundLayer: CALayer!
    
    // MARK: - Inits
    
    /// ``PButton``.
    ///
    /// - Parameter text: Текст кнопки.
    public init(text: String) {
        super.init(frame: .zero)
        
        configureButton(text: text)
        configureLayers()
    }
    
    /// ``PButton``.
    ///
    /// - Parameter coder: Кодировщик.
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    /// Расположить дочерние элементы.
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        configureLayers()
    }
    
    // MARK: - Private
    
    /// Настроить кнопку.
    private func configureButton(text: String) {
        var configuration = UIButton.Configuration.plain()
        
        configuration.baseForegroundColor = UIColor(hexString: "#FFFFFF")
        
        configuration.title = text
        configuration.titleAlignment = .center
        configuration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer({ transformer in
            var resultTransformer = transformer
            resultTransformer.font = UIFont.systemFont(ofSize: 18, weight: .bold)
            
            return resultTransformer
        })
        
        self.configuration = configuration
    }
    
    /// Настроить слой.
    private func configureLayers() {
        if self.backgroundLayer == nil {
            self.backgroundLayer = CALayer()
        }
        
        self.backgroundLayer.frame = self.bounds
        self.backgroundLayer.backgroundColor = UIColor(hexString: "#3CAE1E").cgColor
        self.backgroundLayer.borderWidth = 1
        self.backgroundLayer.borderColor = UIColor(white: 1, alpha: 0.15).cgColor
        self.backgroundLayer.cornerRadius = 24.5
        self.backgroundLayer.masksToBounds = true
        self.layer.insertSublayer(self.backgroundLayer, at: 0)
        
        if self.shadowLayer == nil {
            self.shadowLayer = CALayer()
        }
        
        self.shadowLayer.masksToBounds = false
        self.shadowLayer.shadowOpacity = 1
        self.shadowLayer.shadowRadius = 4
        self.shadowLayer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        self.shadowLayer.shadowOffset = CGSize(width: 0, height: 2)
        self.shadowLayer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: 24.5).cgPath
        
        self.layer.insertSublayer(self.shadowLayer, at: 0)
    }
}
