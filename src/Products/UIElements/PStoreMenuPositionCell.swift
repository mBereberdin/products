//
//  PStoreMenuPositionCell.swift
//  Products
//
//  Created by Mikhail Bereberdin on 03.12.2024.
//

import UIKit

/// Ячейка товара меню магазина.
public final class PStoreMenuPositionCell: UICollectionViewCell {
    
    // MARK: - UI
    
    /// Представление изображения товара.
    private var positionImageView: UIImageView!
    
    /// Надпись наименования товара.
    private var positionNameLabel: UILabel!
    
    /// Надпись цены товара.
    private var positionPriceLabel: UILabel!
    
    /// Счетчик.
    private var stepper: PStepper!
    
    // MARK: - Fields
    
    /// Идентификатор для переиспользования.
    public static let reuseIdentifier = PStoreMenuPositionCell.description()
    
    // MARK: - Inits
    
    /// ``PStoreMenuPositionCell``.
    ///
    /// - Parameter frame: Прямоугольник кадра для представления.
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configureUI()
    }
    
    /// ``PStoreMenuPositionCell``.
    ///
    /// - Parameter coder: Кодировщик.
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    /// Подготовить ячейку для переиспользования.
    public override func prepareForReuse() {
        super.prepareForReuse()
        
        self.setName("")
        self.setPrice("")
        self.setImage(UIImage())
        
        self.stepper.onValueChanged = nil
        self.stepper.setValue(0)
    }
    
    /// Расположить дочерние элементы.
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        self.configureShadow()
    }
    
    /// Установить наименование.
    ///
    /// - Parameter name: Наименование.
    public func setName(_ name: String) {
        self.positionNameLabel.text = name
    }
    
    /// Установить цену.
    ///
    /// - Parameter price: Цена.
    public func setPrice(_ price: String) {
        self.positionPriceLabel.text = "\(price) руб"
    }
    
    /// Установить изображение.
    ///
    /// - Parameter image: Изображение.
    public func setImage(_ image: UIImage) {
        self.positionImageView.image = image
    }
    
    /// Установить количество.
    ///
    /// - Parameter count: Количество.
    public func setCount(_ count: Int) {
        self.stepper.setValue(count)
    }
    
    /// Обработка изменения значения степпера.
    ///
    /// - Parameter handler: Обработчик.
    public func onStepperValueChanged(handler: @escaping (Int)->()) {
        self.stepper.onValueChanged = handler
    }
}

// MARK: - Configure ui extensions
extension PStoreMenuPositionCell {
    
    /// Настроить ui.
    private func configureUI() {
        self.configureContentView()
        
        self.configurePositionPriceLabel()
        self.configureStepper()
        self.configurePositionNameLabel()
        self.configurePositionImageView()
    }
    
    /// Настроить представление контента.
    private func configureContentView() {
        self.contentView.backgroundColor = .white
        self.contentView.layer.cornerRadius = 5
    }
    
    /// Настроить тень.
    private func configureShadow() {
        self.contentView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        self.contentView.layer.shadowOpacity = 1
        self.contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.contentView.layer.shadowRadius = 2
        self.contentView.layer.shadowPath = UIBezierPath(roundedRect: self.contentView.bounds, cornerRadius: 5).cgPath
    }
    
    /// Настроить представление изображения товара.
    private func configurePositionImageView() {
        self.positionImageView = UIImageView()
        
        self.contentView.addSubview(self.positionImageView)
        
        self.positionImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(self.positionNameLabel.snp.top).offset(-10)
        }
        
        self.positionImageView.contentMode = .scaleToFill
        
        self.positionImageView.layer.cornerRadius = 5
        self.positionImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.positionImageView.layer.masksToBounds = true
    }
    
    /// Настроить надпись наименования товара.
    private func configurePositionNameLabel() {
        self.positionNameLabel = UILabel()
        
        self.contentView.addSubview(self.positionNameLabel)
        
        self.positionNameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(11)
            make.trailing.equalToSuperview().inset(11)
            make.bottom.equalTo(self.positionPriceLabel.snp.top).offset(-12)
            make.height.equalTo(18)
        }
        
        self.positionNameLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        self.positionNameLabel.textColor = UIColor(hexString: "#3CAE1E")
        self.positionNameLabel.numberOfLines = 1
        self.positionNameLabel.textAlignment = .left
    }
    
    /// Настроить надпись цены товара.
    private func configurePositionPriceLabel() {
        self.positionPriceLabel = UILabel()
        
        self.contentView.addSubview(self.positionPriceLabel)
        
        self.positionPriceLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(11)
            make.trailing.equalTo(self.contentView.snp.centerX)
            make.bottom.equalToSuperview().inset(11)
            make.height.equalTo(17)
        }
        
        self.positionPriceLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        self.positionPriceLabel.textColor = UIColor(hexString: "#5BC43F")
        self.positionPriceLabel.numberOfLines = 1
        self.positionPriceLabel.textAlignment = .left
    }
    
    /// Настроить счетчик.
    private func configureStepper() {
        self.stepper = PStepper(frame: .zero)
        
        self.contentView.addSubview(self.stepper)
        
        self.stepper.snp.makeConstraints { make in
            make.height.equalTo(24)
            make.leading.equalTo(self.contentView.snp.centerX).offset(3)
            make.trailing.equalToSuperview().inset(5)
            make.bottom.equalToSuperview().inset(7)
        }
    }
}
