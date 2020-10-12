//
//  SampleCollectionViewController.swift
//  CollectionViewPractice
//
//  Created by 竹ノ内愛斗 on 2020/10/12.
//

import UIKit

class SampleCollectionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(collectionView)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }

    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: self.view.bounds, collectionViewLayout: createLayout())
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.register(UINib(nibName: "SampleViewCell", bundle: .main), forCellWithReuseIdentifier: "SampleViewCell")
        view.backgroundColor = .white
        view.dataSource = self
        return view
    }()

    private func createLayout() -> UICollectionViewLayout {
        let width = view.bounds.size.width
        let sideInset: CGFloat = 24
        let topInset: CGFloat = 8
        let insideInset: CGFloat = 8
        let smallSquareWidth: CGFloat = (width - (sideInset * 2 + insideInset * 2)) / 3
        let smallSquareGroupHeight: CGFloat = smallSquareWidth + topInset

        let layout = UICollectionViewCompositionalLayout {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in

            let nestedGroupTypeC: NSCollectionLayoutGroup = {
                let smallSquareItem = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(smallSquareWidth),
                                                      heightDimension: .fractionalHeight(1.0)))

                let smallSquareGroup = NSCollectionLayoutGroup.horizontal(
                    layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .absolute(smallSquareGroupHeight)),
                    subitem: smallSquareItem,
                    count: 3)
                smallSquareGroup.interItemSpacing = .fixed(insideInset)
                smallSquareGroup.contentInsets = NSDirectionalEdgeInsets(top: topInset, leading: 0, bottom: 0, trailing: 0)

                return smallSquareGroup
            }()

            let group = NSCollectionLayoutGroup.vertical(layoutSize:
                                                            NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                                   heightDimension: .absolute(smallSquareGroupHeight * 2)),
                                                         subitems: [nestedGroupTypeC])
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: sideInset, bottom: 0, trailing: sideInset)
            return section
        }
        return layout
    }
}

extension SampleCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 40
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SampleViewCell", for: indexPath) as? SampleViewCell else {
            fatalError("No implemented")
        }
        cell.configureCell(title: "\(indexPath.row)")
        return cell
    }
}
