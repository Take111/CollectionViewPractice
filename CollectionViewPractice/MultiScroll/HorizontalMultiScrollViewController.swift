//
//  HorizontalMultiScrollViewController.swift
//  CollectionViewPractice
//
//  Created by 竹ノ内愛斗 on 2020/10/15.
//

import UIKit

final class HorizontalMultiScrollViewController: UIViewController {

    var navigationTitle = ""

    enum Section {
        case top
    }

    @IBOutlet private  weak var controllView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = navigationTitle
    }


    private func createLayout() -> UICollectionViewLayout {
//        let sectionProvider = { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
//
//        }
        let sectionProvider = UICollectionViewCompositionalLayout { (int, envoirnment) -> NSCollectionLayoutSection? in
            <#code#>
        }
    }
}
