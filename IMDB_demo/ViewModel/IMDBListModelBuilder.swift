//
//  IMDBListModelBuilder.swift
//  IMDB_demo
//
//  Created by Sergey Matveev on 29.03.2023.
//

import Foundation

protocol IMDBListModelBuilder {
    func buildItems(responce: ContextResponce) -> [IMDBItem]?
}

extension IMDBListModelBuilder {
    func buildItems(responce: ContextResponce) -> [IMDBItem]? {
        responce.d?.compactMap({ item in
            IMDBItem(title: item.l, poster: ItemPoster(posterUrl: item.i?.imageUrl, aspect: aspect(poster: item.i)))
        })
    }

    func aspect(poster: Poster?) -> Float? {
        guard let posterWidth = poster?.width, let posterHeight = poster?.height else { return nil }
        return Float(posterWidth)/Float(posterHeight)
    }
}
