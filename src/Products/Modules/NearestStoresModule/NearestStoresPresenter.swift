//
//  NearestStoresPresenter.swift
//  Products
//
//  Created by Mikhail Bereberdin on 20.11.2024.
//

import Foundation

/// ``INearestStoresPresenter``.
public final class NearestStoresPresenter: @preconcurrency INearestStoresPresenter {
    
    // MARK: - Fields
    
    /// Шаблон сообщения расстояния от магазина до пользователя.
    ///
    /// > Tip:
    /// > %d %@ от вас
    private let DISTANCE_AWAY_FROM_USER_MESSAGE_TEMPLATE = "%d %@ от вас"
    
    /// ``INearestStoresView``.
    public weak var view: INearestStoresView!
    
    /// ``INearestStoresInteractor``.
    public var interactor: INearestStoresInteractor!
    
    /// ``INearestStoresRouter``.
    public var router: INearestStoresRouter!
    
    // MARK: - Inits
    
    /// ``INearestStoresPresenter``.
    ///
    /// - Parameter view: ``INearestStoresView``.
    public init(view: INearestStoresView!) {
        self.view = view
    }
    
    // MARK: - Methods
    
    public func onMapButtonTapped() {
        let stores = interactor.stores
        router.showNearestStoresMapView(with: stores)
    }
    
    @MainActor public func viewDidLoad() {
        view.configureUI()
        
        Task(priority: .userInitiated) { @MainActor [] in
            do {
                try await self.interactor.loadStoresAsync()
                try await self.interactor.calculateStoresDistanceAsync()
            } catch let error {
                self.view.showAlert(description: error.localizedDescription)
                
                return
            }
            
            self.view.reloadTable()
        }
        
        self.interactor.setOnLocationAuthorizationChange { [unowned self] in
            Task { @MainActor [unowned self] in
                do {
                    try await self.interactor.calculateStoresDistanceAsync()
                } catch let error {
                    self.view.showAlert(description: error.localizedDescription)
                    
                    return
                }
                
                self.view.reloadTable()
            }
        }
        self.interactor.checkLocationAuthorization()
    }
    
    public func getRowsCount() -> Int {
        interactor.mappedStores.count
    }
    
    @MainActor public func setCellData(at row: Int) {
        if row > interactor.mappedStores.count - 1 || row < 0 {
            return
        }
        
        let store = interactor.mappedStores[row]
        let distanceString: String
        
        if let distance = store.distance {
            let resultDistance: Int
            let resultMeasure: String
            
            if distance > 1000 {
                resultDistance = distance/1000
                resultMeasure = "км"
            } else {
                resultDistance = distance
                resultMeasure = "м"
            }
            
            distanceString = String(format: DISTANCE_AWAY_FROM_USER_MESSAGE_TEMPLATE, resultDistance, resultMeasure)
        } else {
            distanceString = "Не удалось рассчитать."
        }
        
        view.setUpCellInfo(at: row, with: (store.name, distanceString))
    }
    
    public func didSelectRow(_ row: Int) {
        let storeId = self.interactor.stores[row].id
        self.router.showStoreMenuView(storeId: storeId)
    }
}
