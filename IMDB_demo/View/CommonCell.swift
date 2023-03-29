//
//  CommonCell.swift
//  IMDB_demo
//
//  Created by Sergey Matveev on 29.03.2023.
//

import Foundation
import UIKit
import SnapKit
import SDWebImage

class CommonCell: UITableViewCell {

    private var model: IMDBItem?

    private var cover: UIImageView = {
        let cover = UIImageView()
        return cover
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        self.contentView.addSubview(cover)
        applyConstraints()
    }

    private func applyConstraints() {
        cover.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension CommonCell: ConfigurableItem {
    func configure(model: IMDBItem?) {
        self.model = model
        let urlString = model?.poster?.posterUrl ?? ""
        let url = URL(string: urlString)
        cover.sd_setImage(with: url, placeholderImage: nil)
    }
}
