//
//  INearestStoresMapPresenter.swift
//  Products
//
//  Created by Mikhail Bereberdin on 02.12.2024.
//

import MapKit

/// Презентер карты ближайших магазинов.
///
/// Получает от View информацию о действиях пользователя и преображает ее в запросы к Router’у,
/// Interactor’у, а также получает данные от Interactor’a, подготавливает их и отправляет View для отображения.
public protocol INearestStoresMapPresenter: AnyObject {
    
    // MARK: - Fields
    
    /// ``INearestStoresMapView``.
    var view: INearestStoresMapView! { get set }
    
    /// ``INearestStoresMapInteractor``.
    var interactor: INearestStoresMapInteractor! { get set }
    
    /// ``INearestStoresMapRouter``.
    var router: INearestStoresMapRouter! { get set }
    
    // MARK: - Methods
    
    /// Представление было загружено.
    func viewDidLoad()
    
    /// Получить аннотации магазинов.
    ///
    /// - Returns: Аннотации магазинов.
    func getStoreAnnotations() -> [PStoreAnnotation]
    
    /// Получить представление для аннотации.
    ///
    /// - Parameters:
    ///   - mapView: Объект представления карты, который запрашивает представление для аннотации.
    ///   - annotation: Аннотация, для которой необходимо предоставить представление.
    ///
    /// - Returns: Представление аннотации, если аннотация не является локацией пользователя, иначе - nil.
    func getAnnotationView(for mapView: MKMapView, with annotation: MKAnnotation) -> MKAnnotationView?
    
    /// Предоставить магазины.
    ///
    /// - Parameter stores: Магазины.
    func provideStores(_ stores: [StoreDto])
    
    /// Было нажато представление аннотации.
    ///
    /// - Parameter mapView: Представление карты, содержащее представление аннотации,
    /// - Parameter view: Выбранное представление аннотации.
    func annotationViewDidSelect(_ mapView: MKMapView, _ view: MKAnnotationView)
}
