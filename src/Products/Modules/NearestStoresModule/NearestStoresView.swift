//
//  NearestStoresView.swift
//  Products
//
//  Created by Mikhail Bereberdin on 19.11.2024.
//

import UIKit

/// ``INearestStoresView``.
public final class NearestStoresView: UIViewController {
    
    // MARK: - UI
    
    /// Таблица ближайших магазинов.
    private var nearestStoresTable: UITableView!
    
    /// Кнопка "на карте".
    private var onMapButton: PButton!
    
    // MARK: - Fields
    
    /// ``INearestStoresAssembler``.
    public var assembler: INearestStoresAssembler = NearestStoresAssembler()
    
    /// ``INearestStoresPresenter``.
    public var presenter: INearestStoresPresenter!
    
    // MARK: - View life cycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.assembler.assemble(with: self)
        self.presenter.viewDidLoad()
    }
    
    // MARK: - Private
    
    /// Кнопка "на карте" нажата.
    @objc private func onMapButtonTapped() {
        self.presenter.onMapButtonTapped()
    }
}

// MARK: - INearestStoresView extensions
extension NearestStoresView: @preconcurrency INearestStoresView {
    
    public func showNearestStoresMapView(_ showNearestStoresMapView: any INearestStoresMapView) {
        self.navigationController?.pushViewController(showNearestStoresMapView as! UIViewController, animated: true)
    }
    
    public func showStoreMenuView(_ showStoreMenuView: IStoreMenuView) {
        self.navigationController?.pushViewController(showStoreMenuView as! UIViewController, animated: true)
    }
    
    public func setUpCellInfo(at cellRow: Int, with cellInfo: (title: String, subtitle: String)) {
        guard let cell = self.nearestStoresTable.cellForRow(at: IndexPath(row: cellRow, section: 0)) as? PStoreCell else {
            return
        }
        
        cell.setTitle(cellInfo.title)
        cell.setSubTitle(cellInfo.subtitle)
    }
    
    public func showAlert(title: String, description: String) {
        let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "Закрыть", style: .default)
        alert.addAction(closeAction)
        
        self.present(alert, animated: true)
    }
    
    public func configureUI() {
        configureView()
        configureNearestStoresTable()
        configureOnMapButton()
    }
    
    public func reloadTable() {
        self.nearestStoresTable.reloadData()
    }
}

// MARK: - INearestStoresView defaults extensions
extension INearestStoresView {
    
    public func showAlert(title: String = "Ошибка", description: String) {
        self.showAlert(title: title, description: description)
    }
}

// MARK: - Table extensions
extension NearestStoresView: UITableViewDelegate, UITableViewDataSource {
    
    /// Сообщает источнику данных вернуть количество строк в данной секции представления таблицы.
    ///
    /// - Parameters:
    ///   - tableView: Объект представления таблицы, запрашивающий эту информацию.
    ///   - section: Индексный номер, идентифицирующий секцию в tableView.
    ///
    /// - Returns: Количество строк в секции.
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rowsCount = presenter.getRowsCount()
        
        return rowsCount
    }
    
    /// Запрашивает источник данных для вставки ячейки в определенное место представления таблицы.
    ///
    /// - Parameters:
    ///   - tableView: Объект представления таблицы, запрашивающий ячейку.
    ///   - indexPath: Путь индекса, идентифицирующий строку в tableView.
    ///
    /// - Returns: Объект, наследник от UITableViewCell, который представление таблицы может использовать для указанной строки.
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PStoreCell.identifier) as? PStoreCell else {
            return UITableViewCell()
        }
        
        // TODO: Заменить процесс установки информации в ячейки - на получение готовой ячейки из presenter.
        Task(priority: .userInitiated) {
            self.presenter.setCellData(at: indexPath.row)
        }
        
        return cell
    }
    
    /// Сообщает делегату, что строка выбрана.
    ///
    /// - Parameters:
    ///   - tableView: Представление таблицы, информирующее делегата о выборе строки.
    ///   - indexPath: Путь индекса, который указывает на выбранную строку.
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presenter.didSelectRow(indexPath.row)
    }
}

// MARK: - Configure ui extensions
extension NearestStoresView {
    
    /// Настроить представление.
    private func configureView() {
        self.title = "Ближайшие магазины"
        self.view.backgroundColor = .white
    }
    
    /// Настроить таблицу ближайших магазинов.
    private func configureNearestStoresTable() {
        self.nearestStoresTable = UITableView()
        
        self.view.addSubview(self.nearestStoresTable)
        
        self.nearestStoresTable.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        self.nearestStoresTable.delegate = self
        self.nearestStoresTable.dataSource = self
        
        self.nearestStoresTable.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.description())
        self.nearestStoresTable.register(PStoreCell.self, forCellReuseIdentifier: PStoreCell.identifier)
        
        self.nearestStoresTable.rowHeight = 74
        self.nearestStoresTable.separatorColor = UIColor.clear
        self.nearestStoresTable.contentInset = UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0)
    }
    
    /// Настроить кнопку "на карте".
    private func configureOnMapButton() {
        self.onMapButton = PButton(text: "На карте")
        
        self.view.addSubview(self.onMapButton)
        
        self.onMapButton.addTarget(self, action: #selector(self.onMapButtonTapped), for: .touchUpInside)
        
        self.onMapButton.snp.makeConstraints { make in
            make.height.equalTo(48)
            make.bottom.equalTo(self.view.snp.bottom).inset(32)
            make.leading.equalToSuperview().offset(18)
            make.trailing.equalToSuperview().inset(18)
        }
    }
}
