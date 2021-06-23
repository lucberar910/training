//
//  GalleryViewController.swift
//  Training
//
//  Created by Luca Berardinelli on 22/06/21.
//

import UIKit
import Kingfisher

protocol GalleryViewControllerDelegate: class {
  func galleryViewControllerDidSelectElement(_ selectedElement: Children)
}

class GalleryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,
                                UISearchBarDelegate {
    
    
    
//
//    // -------------------------------- COMPOSITIONAL LAYOUT
//    let compositionalLayout: UICollectionViewCompositionalLayout = {
//        let fraction: CGFloat = 1 / 3
//        let inset: CGFloat = 2.5
//        let inset2: CGFloat = 8
//
//        // Supplementary Item
//        let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.1), heightDimension: .absolute(30))
//        let containerAnchor = NSCollectionLayoutAnchor(edges: [.bottom], absoluteOffset: CGPoint(x: 0, y: 10))
//        let supplementaryItem = NSCollectionLayoutSupplementaryItem(layoutSize: layoutSize, elementKind: "new-banner", containerAnchor: containerAnchor)
//        // Item
//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(fraction), heightDimension: .fractionalHeight(1))
////        let item = NSCollectionLayoutItem(layoutSize: itemSize)
////        item.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
//        let item = NSCollectionLayoutItem(layoutSize: itemSize, supplementaryItems: [supplementaryItem])
//        item.contentInsets = NSDirectionalEdgeInsets(top: inset2, leading: inset2, bottom: inset2, trailing: inset2)
//
//        // Group
//        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(fraction))
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
//       // let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//
//        // Section
//        let section = NSCollectionLayoutSection(group: group)
//        let sectionInset: CGFloat = 16
//        section.contentInsets = NSDirectionalEdgeInsets(top: sectionInset, leading: sectionInset, bottom: sectionInset, trailing: sectionInset)
////        section.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
//        let backgroundItem = NSCollectionLayoutDecorationItem.background(elementKind: "background")
//        let backgroundInset: CGFloat = 8
//        backgroundItem.contentInsets = NSDirectionalEdgeInsets(top: backgroundInset, leading: backgroundInset, bottom: backgroundInset, trailing: backgroundInset)
//        section.decorationItems = [backgroundItem]
//
//        let layout = UICollectionViewCompositionalLayout(section: section)
//        layout.register(BackgroundDecorationView.self, forDecorationViewOfKind: "background")
//        return layout
//
////        return UICollectionViewCompositionalLayout(section: section) ---> prima che aggiungessi "let layout"
//    }()
//
//
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        switch kind {
//            case "new-banner":
//                let bannerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "NewBannerSupplementaryView", for: indexPath)
//                bannerView.isHidden = indexPath.row % 5 != 0 // show on every 5th item
//                return bannerView
//
//            default:
//                assertionFailure("Unexpected element kind: \(kind).")
//                return UICollectionReusableView()
//        }
//    }
//
//    // -------------------------------- COMPOSITIONAL LAYOUT
    
    
//    // -------------------------------- COMPOSITIONAL LAYOUT (NESTED GROUPS 1)
//    2 gruppi, di cui uno con un solo item grande mentre l'altro con 2 sottogruppi
//    let compositionalLayout: UICollectionViewCompositionalLayout = {
//        let inset: CGFloat = 2.5
//
//        // Items
//        let largeItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
//        let largeItem = NSCollectionLayoutItem(layoutSize: largeItemSize)
//        largeItem.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
//
//        let smallItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5))
//        let smallItem = NSCollectionLayoutItem(layoutSize: smallItemSize)
//        smallItem.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
//
//        // Nested Group
//        let nestedGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25), heightDimension: .fractionalHeight(1))
//        let nestedGroup = NSCollectionLayoutGroup.vertical(layoutSize: nestedGroupSize, subitems: [smallItem])
//
//        // Outer Group
//        let outerGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.5))
//        let outerGroup = NSCollectionLayoutGroup.horizontal(layoutSize: outerGroupSize, subitems: [largeItem, nestedGroup, nestedGroup])
//
//        // Section
//        let section = NSCollectionLayoutSection(group: outerGroup)
//        section.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
//
//        // Supplementary Item
//        let headerItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(100))
//        let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerItemSize, elementKind: "header", alignment: .top)
//        section.boundarySupplementaryItems = [headerItem]
//
//        return UICollectionViewCompositionalLayout(section: section)
//    }()
//    // -------------------------------- COMPOSITIONAL LAYOUT
    
    // -------------------------------- COMPOSITIONAL LAYOUT (NESTED GROUPS)
    // 2 gruppi, uno sopra l'altro, di cui uno da 2 items ed uno da 3
    let compositionalLayout: UICollectionViewCompositionalLayout = {
        let inset: CGFloat = 2.5
        
        let smallItemSize1 = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
        let smallItem1 = NSCollectionLayoutItem(layoutSize: smallItemSize1)
        smallItem1.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        
        let smallItemSize2 = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(1))
        let smallItem2 = NSCollectionLayoutItem(layoutSize: smallItemSize2)
        smallItem2.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        
        // Nested Group
        let nestedGroupSize1 = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5))
        let nestedGroup1 = NSCollectionLayoutGroup.horizontal(layoutSize: nestedGroupSize1, subitems: [smallItem1])
        
        let nestedGroupSize2 = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5))
        let nestedGroup2 = NSCollectionLayoutGroup.horizontal(layoutSize: nestedGroupSize2, subitems: [smallItem2])

        // Outer Group
        let outerGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.5))
        let outerGroup = NSCollectionLayoutGroup.vertical(layoutSize: outerGroupSize, subitems: [nestedGroup1, nestedGroup2])

        // Section
        let section = NSCollectionLayoutSection(group: outerGroup)
        section.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        
        return UICollectionViewCompositionalLayout(section: section)
    }()
    // -------------------------------- COMPOSITIONAL LAYOUT
    
    
    
    
    @IBOutlet weak var galleryCollectionView: UICollectionView!
    @IBOutlet weak var searchField: UISearchBar!
    weak var delegate: GalleryViewControllerDelegate?
    
    
    var reddit : Reddit?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.galleryCollectionView.dataSource = self
        self.galleryCollectionView.delegate = self
        self.searchField.delegate = self
        //self.feedElements = MockupData.getData() // mockup data
        
        // supplementary item (banner sopra gli item)
        self.galleryCollectionView.register(UINib(nibName: "NewBannerSupplementaryView", bundle: nil), forSupplementaryViewOfKind: "new-banner", withReuseIdentifier: "NewBannerSupplementaryView")
        
        self.galleryCollectionView.collectionViewLayout = compositionalLayout
//        self.galleryCollectionView.collectionViewLayout = CVLayout(nCols: 2, cellHeight: 200, interItemSpace: 10, lineSpace: 10)
        self.galleryCollectionView.register(UINib(nibName: "GalleryItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GalleryItemCollectionViewCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.reddit?.data.children.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let children = self.reddit?.data.children[indexPath.row]
        let c = galleryCollectionView.dequeueReusableCell(withReuseIdentifier: "GalleryItemCollectionViewCell", for: indexPath) as! GalleryItemCollectionViewCell
        if let string = children?.data.url{
            let url = URL(string: string)
            c.imageView.kf.setImage(with: url, placeholder: UIImage(systemName: "pencil.and.outline"))
        } else {
            c.imageView.image = nil
        }
        
        return c
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let item = self.reddit?.data.children[indexPath.row] {
            delegate?.galleryViewControllerDidSelectElement(item)
        }
        
    }
    
    // tasto cerca
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        NetworkManager.shared.search(searchField.text!) { [weak self] result in
            switch result {
                case .success(let reddit):
                    self?.reddit = reddit
                    self?.galleryCollectionView.reloadData()
                case .failure(let error):
                    () // alert view
            }
        }
    }
    

}
