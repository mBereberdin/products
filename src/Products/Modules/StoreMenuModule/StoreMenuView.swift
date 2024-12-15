//
//  StoreMenuView.swift
//  Products
//
//  Created by Mikhail Bereberdin on 02.12.2024.
//

import UIKit

import SnapKit

/// ``IStoreMenuView``.
public final class StoreMenuView: UIViewController {
    
    // MARK: - UI
    
    /// Кнопка перехода к оплате.
    private var paymentButton: PButton!
    
    /// Сетка товаров.
    private var positionsGrid: UICollectionView!
    
    // MARK: - Fields
    
    public var presenter: IStoreMenuPresenter!
    
    public var assembler: IStoreMenuAssembler = StoreMenuAssembler()
    
    // MARK: - Inits
    
    /// ``IStoreMenuView``.
    ///
    /// - Parameters:
    ///   - nibNameOrNil: Наименование файла, описывающего пользовательский интерфейс.
    ///   - nibBundleOrNil: Сборка файла, описывающего пользовательский интерфейс.
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.assembler.assemble(with: self)
    }
    
    /// ``IStoreMenuView``.
    ///
    /// - Parameter coder: Кодировщик.
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View life cycle
    
    /// Представление было загружено
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter.viewDidLoad()
    }
    
    // MARK: - Private
    
    /// Была нажата кнопка "Перейти к оплате".
    @objc private func paymentButtonTapped() {
        self.presenter.onPaymentButtonTapped()
    }
}

// MARK: - IStoreMenuView extensions
extension StoreMenuView: @preconcurrency IStoreMenuView {
    
    public func provideCart(_ cart: [StorePositionDto: Int]) {
        self.presenter.provideCart(cart)
    }
    
    public func reloadPositionsGrid() {
        self.positionsGrid.reloadData()
    }
    
    public func reloadVisiblePositions() {
        let visibleCellIndexPaths = self.positionsGrid.indexPathsForVisibleItems
        self.positionsGrid.reloadItems(at: visibleCellIndexPaths)
    }
    
    public func provideStoreId(_ id: Int) {
        self.presenter.provideStoreId(id)
    }
    
    public func configureUI() {
        self.configureView()
        self.configurePositionGrid()
        self.configurePaymentButton()
    }
    
    public func showStoreCartView(_ view: IStoreCartView) {
        self.navigationController?.pushViewController(view as! UIViewController, animated: true)
    }
}

// MARK: - UICollectionView extensions
extension StoreMenuView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    /// Запрашивает у объекта источника данных представление ячейки,
    /// соответствующей указанному элементу в представлении коллекции.
    ///
    /// > Warning: Вы не должны возвращать `nil` из этого метода.
    ///
    /// - Parameters:
    ///   - collectionView: Представление коллекции, запрашивающее эту информацию.
    ///   - indexPath: Путь индекса, который указывает местоположение элемента.
    ///
    /// - Returns: Настроенный объект ячейки.
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.presenter.getCellForItem(for: collectionView, at: indexPath)
        
        return cell
    }
    
    /// Запрашивает у объекта источника данных количество элементов в указанном разделе.
    ///
    /// - Parameters:
    ///   - collectionView: Представление коллекции, запрашивающее эту информацию.
    ///   - section: Индексный номер, идентифицирующий раздел в collectionView.
    ///
    /// - Returns: Количество элементов в разделе.
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let number = self.presenter.getNumberOfItemsInSection()
        
        return number
    }
    
    /// Запрашивает у делегата размер ячейки указанного элемента.
    ///
    /// - Parameters:
    ///   - collectionView: Представление коллекции, запрашивающее эту информацию.
    ///   - collectionViewLayout: Объект макета, запрашивающий информацию.
    ///   - indexPath: Путь индекса, который указывает местоположение элемента.
    ///
    /// - Returns: Ширина и высота указанного элемента. Оба значения должны быть больше 0.
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // minus insets
        let width = (self.positionsGrid.frame.width - 32) / 2
        let height = (self.positionsGrid.frame.height - 17) / 4
        
        return CGSize(width: width - 6.5, height: height - 6.5)
    }
}

// MARK: - Configure ui extensions
extension StoreMenuView {
    
    /// Настроить представление.
    private func configureView() {
        self.title = "Меню"
        self.view.backgroundColor = .white
    }
    
    /// Настроить сетку товаров.
    private func configurePositionGrid() {
        let collectionViewLayout = UICollectionViewFlowLayout()
        self.positionsGrid = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        
        self.view.addSubview(self.positionsGrid)
        
        self.positionsGrid.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        self.positionsGrid.dataSource = self
        self.positionsGrid.delegate = self
        self.positionsGrid.register(PStoreMenuPositionCell.self, forCellWithReuseIdentifier: PStoreMenuPositionCell.reuseIdentifier)
        self.positionsGrid.contentInset = UIEdgeInsets(top: 17, left: 16, bottom: 0, right: 16)
    }
    
    /// Настроить кнопку перехода к оплате.
    private func configurePaymentButton() {
        self.paymentButton = PButton(text: "Перейти к оплате")
        
        self.view.addSubview(self.paymentButton)
        
        self.paymentButton.snp.makeConstraints { make in
            make.height.equalTo(48)
            make.bottom.equalTo(self.view.snp.bottom).inset(32)
            make.leading.equalToSuperview().offset(18)
            make.trailing.equalToSuperview().inset(18)
        }
        
        self.paymentButton.addTarget(self, action: #selector(paymentButtonTapped), for: .touchUpInside)
    }
}
