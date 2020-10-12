//
//  mainViewController.swift
//  CollectionViewPractice
//
//  Created by 竹ノ内愛斗 on 2020/10/12.
//

import UIKit

final class MainViewController: UIViewController {

    enum Section {
        case main
    }

    enum Content: CaseIterable {
        case sample

        var title: String {
            switch self {
            case .sample:
                return "iOS13 ~ "
            }
        }
    }

    var dataSource: UICollectionViewDiffableDataSource<Section, Content>! = nil
    var subCollectionView: UICollectionView! = nil

    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            collectionView.collectionViewLayout = createLayout()
            collectionView.delegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "CollectionView Practice"
        configureDataSource()
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .grouped)
        return UICollectionViewCompositionalLayout.list(using: config)
    }

    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Content> { (cell, indexPath, item) in
            var content = cell.defaultContentConfiguration()
            content.text = item.title
            cell.contentConfiguration = content
        }
        dataSource = UICollectionViewDiffableDataSource<Section, Content>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        })
        var snapShot = NSDiffableDataSourceSnapshot<Section, Content>()
        snapShot.appendSections([.main])
        snapShot.appendItems(Content.allCases)
        dataSource.apply(snapShot, animatingDifferences: true)
    }
}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch Content.allCases[indexPath.row] {
        case .sample:
            let vc = SampleCollectionViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
