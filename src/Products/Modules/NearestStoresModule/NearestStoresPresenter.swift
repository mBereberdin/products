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
        
        Task {
            do {
                try await interactor.loadStoresAsync()
                try await interactor.calculateStoresDistanceAsync()
            } catch let error {
                view.showAlert(description: error.localizedDescription)
                
                return
            }
            
            view.reloadTable()
        }
    }
    
    public func getRowsCount() -> Int {
        interactor.mappedStores.count
    }
    
    @MainActor public func setCellData(at row: Int) {
        if row > interactor.mappedStores.count - 1 || row < 0 {
            return
        }
        
        let store = interactor.mappedStores[row]
        let distanceString = store.distance > 1000 ?
        String(format: DISTANCE_AWAY_FROM_USER_MESSAGE_TEMPLATE, store.distance/1000, "км") :
        String(format: DISTANCE_AWAY_FROM_USER_MESSAGE_TEMPLATE, store.distance, "м")
        
        view.setUpCellInfo(at: row, with: (store.name, distanceString))
    }
    
    public func didSelectRow(_ row: Int) {
        let storeId = self.interactor.stores[row].id
        self.router.showStoreMenuView(storeId: storeId)
    }
}
