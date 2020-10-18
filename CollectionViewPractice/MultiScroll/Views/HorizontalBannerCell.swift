//
//  HorizontalBannerCell.swift
//  CollectionViewPractice
//
//  Created by 竹ノ内愛斗 on 2020/10/16.
//

import UIKit

class HorizontalBannerCell: UICollectionViewCell {

    @IBOutlet private weak var backgroundColorView: UIView!
    @IBOutlet private weak var numberLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundColor = .gray
    }
}

extension HorizontalBannerCell {

    func configureCell(number: String?) {
        guard let number = number else { return }
        numberLabel.text = number
    }
}
