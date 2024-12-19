//
//  PStoreCell.swift
//  Products
//
//  Created by Mikhail Bereberdin on 19.11.2024.
//

import UIKit

/// Ячейка магазина.
public final class PStoreCell: UITableViewCell {
    
    // MARK: - UI
    
    /// Надпись заголовка.
    private var titleLabel: UILabel!
    
    /// Надпись подзаголовка.
    private var subTitleLabel: UILabel!
    
    /// Контейнер ячейки.
    private var cellContainer: UIView!
    
    // MARK: - Fields
    public static let identifier = PStoreCell.description()
    
    // MARK: - Inits
    
    /// ``PStoreCell``.
    ///
    /// - Parameters:
    ///   - style: Стиль.
    ///   - reuseIdentifier: Идентификатор для переиспользования.
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.configureUI()
    }
    
    /// ``PStoreCell``.
    ///
    /// - Parameter coder: Кодировщик.
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    /// Подготовить ячейку для переиспользования.
    public override func prepareForReuse() {
        self.titleLabel.text = nil
        self.subTitleLabel.text = nil
    }
    
    /// Расположить дочерние элементы.
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        self.contentView.layoutIfNeeded()
        self.configureShadows()
    }
    
    /// Установить заголовок.
    ///
    /// - Parameter titleText: Текст заголовка.
    public func setTitle(_ titleText: String) {
        self.titleLabel.text = titleText
    }
    
    /// Установить подзаголовок.
    ///
    /// - Parameter subTitleText: Текст подзаголовока.
    public func setSubTitle(_ subTitleText: String) {
        self.subTitleLabel.text = subTitleText
    }
    
    // MARK: - Private
    
    /// Настроить тени.
    private func configureShadows() {
        self.cellContainer.layer.shadowOpacity = 1
        self.cellContainer.layer.shadowRadius = 2
        self.cellContainer.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        self.cellContainer.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.cellContainer.layer.shadowPath = UIBezierPath(roundedRect: self.cellContainer.bounds, cornerRadius: 5).cgPath
    }
}

// MARK: - Configure ui extensions
extension PStoreCell {
    
    /// Настроить ui.
    private func configureUI() {
        configureCell()
        configureCellContainer()
        configureTitleLabel()
        configureSubTitleLabel()
    }
    
    /// Настроить ячейку.
    private func configureCell() {
        self.backgroundColor = UIColor.clear
        self.selectionStyle = .none
    }
    
    /// Настроить контейнер ячейки.
    private func configureCellContainer() {
        self.cellContainer = UIView()
        
        self.contentView.addSubview(self.cellContainer)
        
        self.cellContainer.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().inset(6)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().inset(16)
        }
        
        self.cellContainer.layer.cornerRadius = 5
        self.cellContainer.backgroundColor = UIColor(hexString: "#9AE886")
    }
    
    /// Настроить надпись заголовка.
    private func configureTitleLabel() {
        self.titleLabel = UILabel()
        
        self.cellContainer.addSubview(self.titleLabel)
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(14)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().inset(86)
        }
        
        self.titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        self.titleLabel.textColor = Constants.textColor
    }
    
    /// Настроить надпись подзаголовка.
    private func configureSubTitleLabel() {
        self.subTitleLabel = UILabel()
        
        self.cellContainer.addSubview(self.subTitleLabel)
        
        self.subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(6)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().inset(199)
        }
        
        self.subTitleLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        self.subTitleLabel.textColor = UIColor(hexString: "#FFFFFF")
    }
}
