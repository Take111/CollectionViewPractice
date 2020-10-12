//
//  SampleViewCell.swift
//  CollectionViewPractice
//
//  Created by 竹ノ内愛斗 on 2020/10/12.
//

import UIKit

class SampleViewCell: UICollectionViewCell {

    @IBOutlet weak var numberLabel: UILabel!
    func configureCell(title: String?) {
        if let title = title {
            numberLabel.text = title
        }
    }
}
