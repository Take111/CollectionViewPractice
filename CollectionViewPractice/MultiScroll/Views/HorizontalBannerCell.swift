//
//  HorizontalBannerCell.swift
//  CollectionViewPractice
//
//  Created by 竹ノ内愛斗 on 2020/10/16.
//

import UIKit

class HorizontalBannerCell: UICollectionViewCell {

    @IBOutlet private weak var backgroundColorView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

extension HorizontalBannerCell {

    func configureCell(color: UIColor) {
        backgroundColorView.backgroundColor = color
    }
}
