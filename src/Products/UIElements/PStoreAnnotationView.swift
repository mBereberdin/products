//
//  PStoreAnnotationView.swift
//  Products
//
//  Created by Mikhail Bereberdin on 26.11.2024.
//

import SnapKit

import MapKit.MKAnnotationView

/// Представление аннотации карты магазинов.
public final class PStoreAnnotationView: MKAnnotationView {
    
    // MARK: - UI
    
    /// Иконка магазина.
    private var storeImageView: UIImageView!
    
    /// Надпись магазина.
    private var storeLabel: UILabel!
    
    // MARK: - Fields
    
    /// Идентификатор представления.
    public static let identifier = PStoreAnnotationView.description()
    
    // MARK: - Inits
    
    /// ``PStoreAnnotationView``.
    ///
    /// - Parameter frame: Прямоугольник кадра для представления.
    public override init(
        annotation: (any MKAnnotation)?,
        reuseIdentifier: String? = PStoreAnnotationView.identifier
    ) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        self.configureUI()
    }
    
    /// ``PStoreAnnotationView``.
    ///
    /// - Parameter coder: Кодировщик.
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    /// Расположить дочерние элементы.
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        self.configureStoreImageLayer()
    }
    
    /// Подготовить для переиспользования.
    public override func prepareForReuse() {
        super.prepareForReuse()
        
        self.setStoreName("")
    }
    
    /// Установить наименование магазина.
    ///
    /// - Parameter storeName: Наименование магазина.
    public func setStoreName(_ storeName: String) {
        self.storeLabel.text = storeName
    }
    
    // MARK: - Private
    
    /// Настроить слой иконки магазина.
    private func configureStoreImageLayer() {
        let cornerRadius = self.storeImageView.bounds.size.width / 2
        self.storeImageView.layer.cornerRadius = cornerRadius
        self.storeImageView.layer.backgroundColor = UIColor(hexString: "#5BC43F").cgColor
        
        self.storeImageView.layer.shadowPath = UIBezierPath(roundedRect: self.storeImageView.bounds, cornerRadius: cornerRadius).cgPath
        self.storeImageView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        self.storeImageView.layer.shadowOpacity = 1
        self.storeImageView.layer.shadowRadius = 4
        self.storeImageView.layer.shadowOffset = CGSize(width: 0, height: 4)
    }
    
    /// Сообщает этому объекту, что одно или несколько новых касаний произошли в представлении или окне.
    ///
    /// - Parameters:
    ///   - touches: Набор экземпляров UITouch, которые представляют касания для начальной фазы события, которая представлена событием.
    ///   Для касаний в представлении этот набор по умолчанию содержит только одно касание. Чтобы получить несколько касаний,
    ///   вы должны установить свойство `isMultipleTouchEnabled` представления в значение true.
    ///   - event: Событие, к которому принадлежат прикосновения.
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        self.animateTap()
    }
    
    // MARK: - Animations
    
    /// Анимировать нажатие.
    @objc private func animateTap() {
        UIView.animate(withDuration: 0, delay: 0) {
            self.storeImageView.layer.opacity = 0.5
            self.storeLabel.layer.opacity = 0.5
        } completion: { _ in
            UIView.animate(withDuration: 0, delay: 0.4) {
                self.storeImageView.layer.opacity = 1
                self.storeLabel.layer.opacity = 1
            }
        }
    }
}

// MARK: - Configure ui extensions
extension PStoreAnnotationView {
    
    /// Настроить ui.
    private func configureUI() {
        self.configureView()
        self.configureStoreImageView()
        self.configureStoreLabel()
    }
    
    /// Настроить представление.
    private func configureView() {
        self.backgroundColor = UIColor.clear
        self.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        self.canShowCallout = false
    }
    
    /// Настроить иконку магазина.
    private func configureStoreImageView() {
        self.storeImageView = UIImageView()
        
        self.addSubview(self.storeImageView)
        
        self.storeImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(58)
        }
        
        self.storeImageView.image = UIImage(systemName: "storefront")?.withConfiguration(UIImage.SymbolConfiguration(paletteColors: [UIColor(hexString: "#FFFFFF")]))
        self.storeImageView.contentMode = .center
    }
    
    /// Настроить надпись магазина.
    private func configureStoreLabel() {
        self.storeLabel = UILabel()
        
        self.addSubview(self.storeLabel)
        
        self.storeLabel.snp.makeConstraints { make in
            make.top.equalTo(self.storeImageView.snp.bottom).offset(4)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        self.storeLabel.textColor = Constants.textColor
        self.storeLabel.textAlignment = .center
        self.storeLabel.font = .systemFont(ofSize: 14, weight: .bold)
        self.storeLabel.numberOfLines = 2
        self.storeLabel.lineBreakMode = .byTruncatingTail
    }
}
