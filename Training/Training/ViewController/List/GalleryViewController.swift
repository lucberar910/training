//
//  GalleryViewController.swift
//  Training
//
//  Created by Luca Berardinelli on 22/06/21.
//

import UIKit

protocol GalleryViewControllerDelegate: class {
  func galleryViewControllerDidSelectElement(_ selectedElement: FeedElement)
}

class GalleryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,
                                UISearchBarDelegate {
    
    // COMPOSITIONAL LAYOUT
    let compositionalLayout: UICollectionViewCompositionalLayout = {
        let fraction: CGFloat = 1 / 3
        let inset: CGFloat = 2.5

        // Item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(fraction), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        
        // Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(fraction))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        return UICollectionViewCompositionalLayout(section: section)
    }()

    @IBOutlet weak var galleryCollectionView: UICollectionView!
    @IBOutlet weak var searchField: UISearchBar!
    weak var delegate: GalleryViewControllerDelegate?
    
    var feedElements : [FeedElement] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.galleryCollectionView.dataSource = self
        self.galleryCollectionView.delegate = self
        self.searchField.delegate = self
        self.feedElements = MockupData.getData() // mockup data
        self.galleryCollectionView.collectionViewLayout = compositionalLayout
        //        self.galleryCollectionView.collectionViewLayout = CVLayout(nCols: 2, cellHeight: 200, interItemSpace: 10, lineSpace: 10)
        self.galleryCollectionView.register(UINib(nibName: "GalleryItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GalleryItemCollectionViewCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.feedElements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let feedElement = self.feedElements[indexPath.row]
        let c = galleryCollectionView.dequeueReusableCell(withReuseIdentifier: "GalleryItemCollectionViewCell", for: indexPath) as! GalleryItemCollectionViewCell
        c.imageView.image = feedElement.image
        return c
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let feedElement = self.feedElements[indexPath.row]
        delegate?.galleryViewControllerDidSelectElement(feedElement)
//        galleryCollectionView.deselectItem(at: indexPath, animated: true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("aaa")
    }

}
