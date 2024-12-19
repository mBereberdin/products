//
//  StoreCartPresenter.swift
//  Products
//
//  Created by Mikhail Bereberdin on 09.12.2024.
//

import Foundation

import UIKit.UITableView
import UIKit.UITableViewCell

/// ``IStoreCartPresenter``.
public final class StoreCartPresenter: @preconcurrency IStoreCartPresenter {
    
    // MARK: - Fields
    
    public weak var view: IStoreCartView!
    
    public var interactor: IStoreCartInteractor!
    
    // MARK: - Inits
    
    /// ``IStoreCartPresenter``.
    ///
    /// - Parameter view: ``IStoreCartView``.
    public init(view: IStoreCartView) {
        self.view = view
    }
    
    // MARK: - Methods
    
    public func viewDidLoad() {
        view.configureUI()
    }
    
    public func viewDidAppear() {
        view.scrollTableToUp()
    }
    
    public func viewWillDisappear() {
        let cart = self.interactor.cart
        view.returnCart(cart)
    }
    
    public func provideCart(_ cart: [StorePositionDto : Int]) {
        self.interactor.setCart(cart)
    }
    
    public func getNumberOfItemsInSection() -> Int {
        let number = self.interactor.cart.count
        
        return number
    }
    
    @MainActor public func getCellForItem(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PStoreCartCell.reuseIdentifier, for: indexPath)
                as? PStoreCartCell else {
            return UITableViewCell()
        }
        
        let position = self.interactor.getPosition(at: indexPath.row)
        cell.setTitle(position.info.name)
        cell.setSubTitle("\(position.info.price) руб")
        cell.setCount(position.count)
        cell.onStepperValueChanged { newValue in
            self.interactor.setPositionCount(positionId: position.info.id, count: newValue)
            if newValue == 0 {
                self.view.removeCell(at: indexPath)
                
                return
            }
        }
        
        return cell
    }
}
