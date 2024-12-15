//
//  StoreCartView.swift
//  Products
//
//  Created by Mikhail Bereberdin on 08.12.2024.
//

import UIKit

import SnapKit

/// ``IStoreCartView``.
public final class StoreCartView: UIViewController {
    
    // MARK: - UI
    
    /// Таблица позиций.
    private var positionsTable: UITableView!
    
    /// Кнопка оплаты.
    private var payButton: PButton!
    
    // MARK: - Fields
    
    public var presenter: IStoreCartPresenter!
    
    public var assembler: IStoreCartAssembler = StoreCartAssembler()
    
    // MARK: - Inits
    
    /// ``IStoreCartView``.
    ///
    /// - Parameters:
    ///   - nibNameOrNil: Наименование файла, описывающего пользовательский интерфейс.
    ///   - nibBundleOrNil: Сборка файла, описывающего пользовательский интерфейс.
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.assembler.assemble(with: self)
    }
    
    /// ``IStoreCartView``.
    ///
    /// - Parameter coder: Кодировщик.
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View life cycle
    
    /// Представление было загружено.
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter.viewDidLoad()
    }
    
    /// Представление было показано.
    ///
    /// - Parameter animated: Было ли показано с анимацией.
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.presenter.viewDidAppear()
    }
    
    /// Представление будет скрыто.
    ///
    /// - Parameter animated: Будет ли скрыто с анимацией.
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.presenter.viewWillDisappear()
    }
}

// MARK: - IStoreCartView extensions
extension StoreCartView: @preconcurrency IStoreCartView {
    
    public func returnCart(_ cart: [StorePositionDto: Int]) {
        guard let storeMenuView = self.navigationController?.topViewController as? IStoreMenuView else {
            return
        }
        
        storeMenuView.provideCart(cart)
        storeMenuView.reloadVisiblePositions()
    }
    
    public func removeCell(at indexPath: IndexPath) {
        self.positionsTable.deleteRows(at: [indexPath], with: .left)
        let visibleCellIndexPathes = self.positionsTable.indexPathsForVisibleRows ?? []
        self.positionsTable.reloadRows(at: visibleCellIndexPathes, with: .none)
    }
    
    public func provideCart(_ cart: [StorePositionDto : Int]) {
        self.presenter.provideCart(cart)
    }
    
    public func configureUI() {
        self.configureView()
        self.configurePositionsTable()
        self.configurePayButton()
    }
    
    public func scrollTableToUp() {
        if self.positionsTable.visibleCells.count > 0 {
            self.positionsTable.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
        }
    }
}

// MARK: - Configure ui extensions
extension StoreCartView: UITableViewDelegate, UITableViewDataSource {
    
    /// Сообщает источнику данных вернуть количество строк в данной секции представления таблицы.
    ///
    /// - Parameters:
    ///   - tableView: Объект представления таблицы, запрашивающий эту информацию.
    ///   - section: Индексный номер, идентифицирующий секцию в tableView.
    ///
    /// - Returns: Количество строк в секции.
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let number = self.presenter.getNumberOfItemsInSection()
        
        return number
    }
    
    /// Запрашивает источник данных для вставки ячейки в определенное место представления таблицы.
    ///
    /// - Parameters:
    ///   - tableView: Объект представления таблицы, запрашивающий ячейку.
    ///   - indexPath: Путь индекса, идентифицирующий строку в tableView.
    ///
    /// - Returns: Объект, наследник от UITableViewCell, который представление таблицы может использовать для указанной строки.
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.presenter.getCellForItem(for: tableView, at: indexPath)
        
        return cell
    }
}

// MARK: - Configure ui extensions
extension StoreCartView {
    
    /// Настроить представление.
    private func configureView() {
        self.title = "Ваш заказ"
        self.view.backgroundColor = .white
    }
    
    /// Настроить таблицу позиций.
    private func configurePositionsTable() {
        self.positionsTable = UITableView()
        
        self.view.addSubview(self.positionsTable)
        
        self.positionsTable.snp.makeConstraints { make in
            make.directionalEdges.equalToSuperview()
        }
        
        self.positionsTable.dataSource = self
        self.positionsTable.delegate = self
        
        self.positionsTable.register(PStoreCartCell.self, forCellReuseIdentifier: PStoreCartCell.reuseIdentifier)
        
        self.positionsTable.rowHeight = 74
        self.positionsTable.separatorColor = UIColor.clear
        self.positionsTable.contentInset = UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0)
        
        self.configureTableFooter()
    }
    
    /// Настроить подвал таблицы.
    private func configureTableFooter() {
        let footerLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 300))
        footerLabel.backgroundColor = .clear
        
        footerLabel.text = "Время ожидания заказа 15 минут!\nСпасибо, что выбрали нас!"
        footerLabel.textAlignment = .center
        footerLabel.textColor = Constants.textColor
        footerLabel.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        footerLabel.numberOfLines = 0
        
        self.positionsTable.tableFooterView = footerLabel
    }
    
    /// Настроить кнопку оплаты.
    private func configurePayButton() {
        self.payButton = PButton(text: "Оплатить")
        
        self.view.addSubview(self.payButton)
        
        self.payButton.snp.makeConstraints { make in
            make.height.equalTo(48)
            make.bottom.equalTo(self.view.snp.bottom).inset(32)
            make.leading.equalToSuperview().offset(18)
            make.trailing.equalToSuperview().inset(18)
        }
    }
}
