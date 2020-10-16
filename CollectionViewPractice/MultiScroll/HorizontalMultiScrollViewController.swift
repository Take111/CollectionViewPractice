//
//  HorizontalMultiScrollViewController.swift
//  CollectionViewPractice
//
//  Created by 竹ノ内愛斗 on 2020/10/15.
//

import UIKit

final class HorizontalMultiScrollViewController: UIViewController {

    enum Section: CaseIterable {
        case top
    }

    @IBOutlet private weak var collectionView: UICollectionView!

    var navigationTitle = ""
    var dataSource: UICollectionViewDiffableDataSource<Section, Int>! = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = navigationTitle
        collectionView.collectionViewLayout = createLayout()
        configureTopDataSource()
    }


    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, envoirnment) -> NSCollectionLayoutSection? in
            let section: NSCollectionLayoutSection

            switch Section.allCases[sectionIndex] {
            case .top:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
                let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(CGFloat(120)), heightDimension: .absolute(120))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = -12
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)
            }
            return section
        }
        return layout
    }

    private func configureTopDataSource() {
        let nib = UINib(nibName: "HorizontalViewCell", bundle: nil)
        let cellRegistration = UICollectionView.CellRegistration<HorizontalViewCell, Int>(cellNib: nib) { (cell, indexPath, number) in
            cell.configureCell(title: "\(indexPath.row)")
        }
        dataSource = UICollectionViewDiffableDataSource<Section, Int>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, number) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: number)
        })

        var snapShot = NSDiffableDataSourceSnapshot<Section, Int>()
        snapShot.appendSections(Section.allCases)
        snapShot.appendItems(Array(0..<10))
        dataSource.apply(snapShot, animatingDifferences: true)
    }

    private func configureBannerDataSource() {
        
    }
}
