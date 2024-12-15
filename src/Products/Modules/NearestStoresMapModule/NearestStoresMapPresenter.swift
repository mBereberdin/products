//
//  NearestStoresMapPresenter.swift
//  Products
//
//  Created by Mikhail Bereberdin on 02.12.2024.
//

import MapKit

/// ``INearestStoresMapPresenter``.
public final class NearestStoresMapPresenter: @preconcurrency INearestStoresMapPresenter {
    
    // MARK: - Fields
    
    /// ``INearestStoresMapView``.
    public weak var view: INearestStoresMapView!
    
    /// ``INearestStoresMapInteractor``.
    public var interactor: INearestStoresMapInteractor!
    
    /// ``INearestStoresMapRouter``.
    public var router: INearestStoresMapRouter!
    
    // MARK: - Inits
    
    /// ``INearestStoresMapPresenter``.
    ///
    /// - Parameter view: ``INearestStoresMapView``.
    public init(view: INearestStoresMapView!) {
        self.view = view
    }
    
    // MARK: - Methods
    
    public func viewDidLoad() {
        self.view.configureUI()
        
        let storeAnnotation = self.getStoreAnnotations()
        self.view.showStoreAnnotations(storeAnnotation)
    }
    
    public func getStoreAnnotations() -> [PStoreAnnotation] {
        var storeAnnotations: [PStoreAnnotation] = []
        for store in interactor.stores {
            let coordinate = CLLocationCoordinate2D(latitude: store.location.latitude,
                                                    longitude: store.location.longitude)
            let storeAnnontation = PStoreAnnotation(id: store.id, title: store.name, coordinate: coordinate)
            storeAnnotations.append(storeAnnontation)
        }
        
        return storeAnnotations
    }
    
    @MainActor public func getAnnotationView(for mapView: MKMapView, with annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        guard let storeAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: PStoreAnnotationView.identifier) as? PStoreAnnotationView else {
            return nil
        }
        
        guard  let annotationTitle = annotation.title,
               let storeName = annotationTitle else {
            fatalError("No store name for annotation")
        }
        
        storeAnnotationView.setStoreName(storeName)
        
        return storeAnnotationView
    }
    
    public func provideStores(_ stores: [StoreDto]) {
        self.interactor.setStores(stores)
    }
    
    @MainActor public func annotationViewDidSelect(_ mapView: MKMapView, _ view: MKAnnotationView) {
        guard let storeAnnotation = view.annotation as? PStoreAnnotation else { return }
        mapView.deselectAnnotation(storeAnnotation, animated: true)
        
        let storeId = storeAnnotation.id
        self.router.showStoreMenuView(storeId: storeId)
    }
}
