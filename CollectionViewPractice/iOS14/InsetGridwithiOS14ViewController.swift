//
//  InsetGridwithiOS14ViewController.swift
//  CollectionViewPractice
//
//  Created by 竹ノ内愛斗 on 2020/10/13.
//

import UIKit

final class InsetGridwithiOS14ViewController: UIViewController {

    enum Section {
        case main
    }

    @IBOutlet private weak var collectionView: UICollectionView!

    var navigationTitle = ""

    var dataSource: UICollectionViewDiffableDataSource<Section, Int>! = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.collectionViewLayout = createLayout()
        configureDataSource()

        navigationItem.title = navigationTitle
    }

    private func createLayout() -> UICollectionViewLayout {
        let width = view.bounds.size.width
        let sideInset: CGFloat = 24
        let topInset: CGFloat = 8
        let insideInset: CGFloat = 8
        let smallSquareWidth: CGFloat = (width - (sideInset * 2 + insideInset * 2)) / 3
        let smallSquareGroupHeight: CGFloat = smallSquareWidth + topInset

        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                             heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .absolute(smallSquareGroupHeight))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
        let spacing = CGFloat(10)
        group.interItemSpacing = .fixed(spacing)
        group.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0)

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = spacing
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: sideInset, bottom: 0, trailing: sideInset)

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }

    private func configureDataSource() {
        let nib = UINib(nibName: "SampleViewCell", bundle: nil)
        let cellRegistration = UICollectionView.CellRegistration<SampleViewCell, Int>(cellNib: nib) { (cell, indexPath, item) in
            cell.configureCell(title: "\(indexPath.row)")
        }
        dataSource = UICollectionViewDiffableDataSource<Section, Int>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        })

        var snapShot = NSDiffableDataSourceSnapshot<Section, Int>()
        snapShot.appendSections([.main])
        snapShot.appendItems(Array(0..<40))
        dataSource.apply(snapShot, animatingDifferences: false)
    }
}
