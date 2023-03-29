//
//  ConfigurableItem.swift
//  IMDB_demo
//
//  Created by Sergey Matveev on 29.03.2023.
//

import Foundation

protocol ConfigurableItem {
    func configure(model: IMDBItem?)
    static func calculateHeight(model: IMDBItem?, width: CGFloat) -> CGFloat
}

extension ConfigurableItem {
    static func calculateHeight(model: IMDBItem?, width: CGFloat) -> CGFloat {
        guard let aspect = model?.poster?.aspect, aspect > 0 else { return 0 }
        return width/CGFloat(aspect)
    }
}
