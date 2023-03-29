//
//  ItemsListView.swift
//  IMDB_demo
//
//  Created by Sergey Matveev on 29.03.2023.
//

import Foundation
import UIKit
import SnapKit

class ItemsListView: UIView {

    var items: [IMDBItem]? {
        didSet {
            tableView.reloadData()
        }
    }

    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.separatorStyle = .none
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        }
        return tableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {

        self.addSubview(tableView)

        tableView.dataSource = self
        tableView.delegate = self

        for (cell, identifier) in cellClassWithIdentifier() {
            tableView.register(cell, forCellReuseIdentifier: identifier)
        }

        applyConstraints()
    }

    private func applyConstraints() {
        self.tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension ItemsListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = items?[indexPath.row] else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier(item.type.rawValue), for: indexPath)
        (cell as? ConfigurableItem)?.configure(model: item)
        return cell
    }
}

extension ItemsListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let configurableClass = ItemsListView.cellClassFrom(cellType: items?[indexPath.row].type) as? ConfigurableItem.Type {
            return configurableClass.calculateHeight(model: items?[indexPath.row], width: tableView.bounds.width)
        }
        return 0
    }
}

extension ItemsListView {
    static let cellMap: [ItemType: UITableViewCell.Type] = [.common: CommonCell.self]

    func cellClassWithIdentifier() -> [(cellClass: UITableViewCell.Type?, id: String)] {
        var result = [(UITableViewCell.Type?, String)]()
        for cell in Self.cellMap.keys {
            result.append((Self.cellMap[cell], cell.rawValue))
        }
        return result
    }

    func cellIdentifier(_ key: String) -> String {
        return key
    }

    static func cellClassFrom(cellType: ItemType?) -> UITableViewCell.Type {
        guard let cellType = cellType else { return UITableViewCell.self }
        return self.cellMap[cellType] ?? UITableViewCell.self
    }
}

