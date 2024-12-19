//
//  StoreMenuPresenter..swift
//  Products
//
//  Created by Mikhail Bereberdin on 04.12.2024.
//

import Foundation

import UIKit.UICollectionView

/// ``IStoreMenuPresenter``.
public final class StoreMenuPresenter: @preconcurrency IStoreMenuPresenter {
    
    // MARK: - Fields
    
    /// ``IStoreMenuView``.
    public weak var view: IStoreMenuView!
    
    /// ``IStoreMenuInteractor``.
    public var interactor: IStoreMenuInteractor!
    
    /// ``IStoreMenuRouter``.
    public var router: IStoreMenuRouter!
    
    // MARK: - Inits
    
    /// ``IStoreMenuPresenter``.
    ///
    /// - Parameter view: ``IStoreMenuView``.
    public init(view: IStoreMenuView) {
        self.view = view
    }
    
    // MARK: - Methods
    
    @MainActor public func viewDidLoad() {
        view.configureUI()
        
        Task(priority: .userInitiated) {
            try await self.interactor.loadStorePositionsAsync()
            try await self.interactor.mapStoreImagesAsync()
            
            view.reloadPositionsGrid()
        }
    }
    
    public func provideStoreId(_ id: Int) {
        self.interactor.setStoreId(id)
    }
    
    public func provideCart(_ cart: [StorePositionDto: Int]) {
        let mappedCart = cart.reduce(into: [Int: Int]()) {
            $0[$1.key.id] = $1.value
        }
        self.interactor.setCart(mappedCart)
    }
    
    public func getNumberOfItemsInSection() -> Int {
        let number = interactor.mappedPositions.count
        
        return number
    }
    
    @MainActor public func getCellForItem(for collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PStoreMenuPositionCell.reuseIdentifier,
                                                            for: indexPath) as? PStoreMenuPositionCell else {
            return UICollectionViewCell()
        }
        
        let position = self.interactor.mappedPositions[indexPath.row]
        cell.setName(position.name)
        cell.setPrice(String(position.price))
        cell.setImage(position.image)
        
        if let addedCount = self.interactor.cart[position.id] {
            cell.setCount(addedCount)
        }
        
        cell.onStepperValueChanged { newValue in
            self.interactor.setPositionCount(positionId: position.id, count: newValue)
        }
        
        return cell
    }
    
    public func onPaymentButtonTapped() {
        var cart: [StorePositionDto : Int] = [:]
        
        for (positionId, count) in self.interactor.cart {
            guard let position = self.interactor.positions.first(where: { $0.id == positionId }) else {
                fatalError("Position not found")
            }
            
            cart[position] = count
        }
        
        self.router.showStoreCartView(with: cart)
    }
}
