//
//  StoreCartInteractor.swift
//  Products
//
//  Created by Mikhail Bereberdin on 09.12.2024.
//

import Foundation

/// ``IStoreCartInteractor``.
public final class StoreCartInteractor: IStoreCartInteractor {
    
    // MARK: - Fields
    
    // TODO: Переделать обращение к элементам корзины, чтобы не было надобности дублировать позиции в отдельный массив.
    
    /// Позиции.
    private var _positions: [StorePositionDto]
    
    public weak var presenter: IStoreCartPresenter!
    
    public var cart: [StorePositionDto: Int]
    
    // MARK: - Inits
    
    /// ``IStoreCartInteractor``.
    ///
    /// - Parameter presenter: ``IStoreCartPresenter``.
    public init(presenter: IStoreCartPresenter) {
        self.presenter = presenter
        
        self.cart = [:]
        self._positions = []
    }
    
    // MARK: - Methods
    
    public func setPositionCount(positionId: Int, count: Int) {
        guard let positionIndex = _positions.firstIndex(where: { $0.id == positionId }) else {
            return
        }
        
        let position = _positions[positionIndex]
        if count == 0 {
            self.cart[position] = nil
            self._positions.remove(at: positionIndex)
            
            return
        }
        
        cart[position] = count
    }
    
    public func setCart(_ cart: [StorePositionDto : Int]) {
        self.cart = cart
        self._positions = cart.keys.map({ $0 })
    }
    
    public func getPosition(at index: Int) -> (info: StorePositionDto, count: Int) {
        let position = _positions[index]
        let count = cart[position]!
        
        return (position, count)
    }
}
