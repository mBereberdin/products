//
//  NearestStoresMapView.swift
//  Products
//
//  Created by Mikhail Bereberdin on 26.11.2024.
//

import UIKit
import MapKit
import SnapKit

/// ``INearestStoresMapView``.
public final class NearestStoresMapView: UIViewController {
    
    // MARK: - UI
    
    /// Представление карты.
    private var mapView: MKMapView!
    
    // MARK: - Fields
    
    /// ``INearestStoresAssembler``.
    public var assembler: INearestStoresMapAssembler = NearestStoresMapAssembler()
    
    /// ``INearestStoresPresenter``.
    public var presenter: INearestStoresMapPresenter!
    
    // MARK: - Inits
    
    /// ``INearestStoresMapView``.
    public init() {
        super.init(nibName: nil, bundle: nil)
        
        self.assembler.assemble(with: self)
    }
    
    /// ``INearestStoresMapView``.
    ///
    /// - Parameter coder: Кодировщик.
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View life cycle
    
    /// Предсталвение было загружено.
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter.viewDidLoad()
    }
}

// MARK: - INearestStoresMapView extensions
extension NearestStoresMapView: @preconcurrency INearestStoresMapView {
    
    public func showStoreMenuView(_ view: IStoreMenuView) {
        self.navigationController?.pushViewController(view as! UIViewController, animated: true)
    }
    
    public func provideStores(_ stores: [StoreDto]) {
        self.presenter.provideStores(stores)
    }
    
    public func configureUI() {
        self.configureView()
        self.configureMapView()
    }
    
    public func showStoreAnnotations(_ storeAnnotations: [PStoreAnnotation]) {
        for storeAnnotation in storeAnnotations {
            self.mapView.addAnnotation(storeAnnotation)
        }
    }
}

// MARK: - Configure ui extensions
extension NearestStoresMapView {
    
    /// Настроить представление.
    private func configureView() {
        self.title = "Карта"
    }
    
    /// Настроить представление карты.
    private func configureMapView() {
        self.mapView = MKMapView()
        
        self.view.addSubview(self.mapView)
        
        self.mapView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        
        self.mapView.showsUserLocation = true
        self.mapView.delegate = self
        self.mapView.register(PStoreAnnotationView.self,
                              forAnnotationViewWithReuseIdentifier: PStoreAnnotationView.identifier)
    }
}

// MARK: - MKMapViewDelegate extensions
extension NearestStoresMapView: MKMapViewDelegate {
    
    /// Возвращает представление, связанное с указанным объектом аннотации.
    ///
    /// - Parameters:
    ///   - mapView: Представление карты, которое запрашивает представление аннотации.
    ///   - annotation: Объект, представляющий аннотацию, которую необходимо отобразить в представлении карты.
    ///   В дополнение к вашим пользовательским аннотациям, этот объект может быть объектом MKUserLocation, представляющим местоположение пользователя.
    ///
    /// - Returns: Представление аннотации для отображения указанной аннотации или nil, если вы хотите отобразить стандартный вид аннотации.
    ///
    /// Вместо того, чтобы создавать новое представление каждый раз, когда представление карты вызывает этот метод,
    /// вызовите метод dequeueReusableAnnotationView(withIdentifier:) класса MKMapView, чтобы проверить,
    /// существует ли уже существующее представление аннотаций желаемого типа. Если он существует,
    /// обновите возвращенное представление, чтобы отразить атрибуты указанной аннотации, и верните его.
    /// Если представление соответствующего типа не существует, создайте его, настройте его с необходимыми данными аннотации и верните его.
    ///
    /// Если объект в параметре аннотации является экземпляром класса MKUserLocation,
    /// вы можете предоставить пользовательское представление для обозначения местоположения пользователя.
    /// Чтобы отобразить местоположение пользователя с помощью системного представления по умолчанию, верните nil.
    ///
    /// Если вы не реализуете этот метод или если вы возвращаете nil из своей реализации для аннотаций,
    /// отличных от аннотации местоположения пользователя, представление карты использует стандартное представление аннотаций вывода.
    public func mapView(_ mapView: MKMapView, viewFor annotation: any MKAnnotation) -> MKAnnotationView? {
        let annotationView = self.presenter.getAnnotationView(for: mapView, with: annotation)
        
        return annotationView
    }
    
    /// Сообщает делегату, когда пользователь выбирает один или несколько его представлений аннотаций.
    ///
    /// - Parameters:
    ///   - mapView: Представление карты, содержащее представление аннотации.
    ///   - view: Выбранное представление аннотации.
    public func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        self.presenter.annotationViewDidSelect(mapView, view)
    }
}
