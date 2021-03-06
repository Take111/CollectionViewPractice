//
//  HorizontalViewCell.swift
//  CollectionViewPractice
//
//  Created by 竹ノ内愛斗 on 2020/10/15.
//

import UIKit

class HorizontalViewCell: UICollectionViewCell {

    @IBOutlet private weak var circleView: UIView! {
        didSet {
            circleView.backgroundColor = .lightGray
            circleView.layer.masksToBounds = true
            circleView.layer.cornerRadius = CGFloat(12)
        }
    }

    @IBOutlet private weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

extension HorizontalViewCell {

    func configureCell(title: String) {
        titleLabel.text = title
    }
}
