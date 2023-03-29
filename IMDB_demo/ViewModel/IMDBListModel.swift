//
//  IMDBListModel.swift
//  IMDB_demo
//
//  Created by Sergey Matveev on 29.03.2023.
//

import Foundation

enum ItemType: String {
    case common
}

struct ItemPoster {
    let posterUrl: String?
    let aspect: Float?
}

struct IMDBItem {
    let title: String?
    let poster: ItemPoster?
    let type: ItemType = .common
}

protocol IMDBListModel {
    func loadIMDBItems(completion: @escaping (Bool, [IMDBItem]?) -> Void)
}

class IMDBListModelImpl: IMDBListModel, IMDBListModelBuilder {
    func loadIMDBItems(completion: @escaping (Bool, [IMDBItem]?) -> Void) {
        IMDBService.shared.loadIMDBItems(context: "terminator") { [weak self] responce, success in
            var items: [IMDBItem]?
            if let responce = responce {
                items = self?.buildItems(responce: responce)
            }
            DispatchQueue.main.async {
                completion(success, items)
            }
        }
    }
}
