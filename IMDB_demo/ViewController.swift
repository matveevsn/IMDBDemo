//
//  ViewController.swift
//  IMDB_demo
//
//  Created by Sergey Matveev on 28.03.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    private var imdbItemsList: IMDBListModel?

    private var itemsListView: ItemsListView = {
        let itemsListView = ItemsListView()
        return itemsListView
    }()

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        imdbItemsList = IMDBListModelImpl()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        imdbItemsList = IMDBListModelImpl()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(itemsListView)

        applyConstraints()

        imdbItemsList?.loadIMDBItems(completion: { [weak self] success, itemsList in
            self?.itemsListView.items = itemsList
        })
    }

    private func applyConstraints() {
        itemsListView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
