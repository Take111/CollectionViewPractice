//
//  HorizontalMultiScrollViewController.swift
//  CollectionViewPractice
//
//  Created by 竹ノ内愛斗 on 2020/10/15.
//

import UIKit

final class HorizontalMultiScrollViewController: UIViewController {

    enum Section: Int, CaseIterable {
        case banner, cricle
    }

    @IBOutlet private weak var collectionView: UICollectionView!

    var navigationTitle = ""
    var dataSource: UICollectionViewDiffableDataSource<Section, Int>! = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = navigationTitle
        collectionView.collectionViewLayout = createLayout()
        configureDataSource()
    }

    private func createLayout() -> UICollectionViewLayout {
        let sectionProvider = UICollectionViewCompositionalLayout { (sectionIndex, envoirnment) -> NSCollectionLayoutSection? in
            let section: NSCollectionLayoutSection

            switch Section.allCases[sectionIndex] {
            case .banner:
//                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
//                let item = NSCollectionLayoutItem(layoutSize: itemSize)
//                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(56))
//                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//                section = NSCollectionLayoutSection(group: group)
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
                let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(CGFloat(120)), heightDimension: .absolute(120))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = -12
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)
            case .cricle:
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
        return sectionProvider
    }

//    private func configureTopDataSource() {
//        let nib = UINib(nibName: "HorizontalViewCell", bundle: nil)
//        let cellRegistration = UICollectionView.CellRegistration<HorizontalViewCell, Int>(cellNib: nib) { (cell, indexPath, number) in
//            cell.configureCell(title: "\(indexPath.row)")
//        }
//        dataSource = UICollectionViewDiffableDataSource<Section, Int>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, number) -> UICollectionViewCell? in
//            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: number)
//        })
//
//        var snapShot = NSDiffableDataSourceSnapshot<Section, Int>()
//        snapShot.appendSections(Section.allCases)
//        snapShot.appendItems(Array(0..<10))
//        dataSource.apply(snapShot, animatingDifferences: true)
//    }

    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Int>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
            guard let section = Section(rawValue: indexPath.section) else { fatalError("Unknown section") }
            switch section {
            case .banner:
                return collectionView.dequeueConfiguredReusableCell(using: self.configureBannerDataSource(), for: indexPath, item: item)
            case .cricle:
                return collectionView.dequeueConfiguredReusableCell(using: self.configureCircleDataSource(), for: indexPath, item: item)
            }
        })

        let array = [1, 2, 3, 4, 5]

        // set section
        let sections = Section.allCases
        var snapShot = NSDiffableDataSourceSnapshot<Section, Int>()
        snapShot.appendSections(sections)
        dataSource.apply(snapShot, animatingDifferences: true)

        // set value for banner
        var bannerSnapShot = NSDiffableDataSourceSectionSnapshot<Int>()
        bannerSnapShot.append(array)
        dataSource.apply(bannerSnapShot, to: .banner, animatingDifferences: false)

        // set value for circle
        var circleSnapShot = NSDiffableDataSourceSectionSnapshot<Int>()
        circleSnapShot.append(array)
        dataSource.apply(circleSnapShot, to: .cricle, animatingDifferences: false)
    }

    private func configureBannerDataSource() -> UICollectionView.CellRegistration<HorizontalViewCell, Int> {
        let nib = UINib(nibName: "HorizontalBannerCell", bundle: nil)
        return UICollectionView.CellRegistration<HorizontalViewCell, Int>(cellNib: nib) { cell, indexPath, number in
            cell.configureCell(title: "\(number)")
        }
    }

    private func configureCircleDataSource() -> UICollectionView.CellRegistration<HorizontalViewCell, Int> {
        let nib = UINib(nibName: "HorizontalViewCell", bundle: nil)
        return UICollectionView.CellRegistration<HorizontalViewCell, Int>(cellNib: nib) { cell, indexPath, number in
            cell.configureCell(title: "\(number)")
        }
    }
}
