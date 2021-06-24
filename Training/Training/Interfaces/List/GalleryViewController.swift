//
//  GalleryViewController.swift
//  Training
//
//  Created by Luca Berardinelli on 22/06/21.
//

import UIKit
import Kingfisher
import Combine

protocol GalleryViewControllerDelegate: class {
  func galleryViewControllerDidSelectElement(_ selectedElement: Beer)
}

class GalleryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,
                             UISearchBarDelegate, ViewModellable {
    
    
    
    typealias ViewModelType = GalleryViewModel
    

    var viewModel: GalleryViewModel
    
    
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
    @IBOutlet weak var labelEmpty: UILabel!
    var cancellables = Set<AnyCancellable>()
    
    init(viewModel: GalleryViewModel, delegate: GalleryViewControllerDelegate ) {
        self.viewModel = viewModel
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        bindViewModel() // subscriber
    }
    
    func bindViewModel(){
        viewModel.$beers.sink { [weak self] beers in
            if(beers.count == 0){
                self?.labelEmpty.isHidden = false
                self?.labelEmpty.text = "Nessun risultato"
                self?.galleryCollectionView.isHidden = true
            } else {
                self?.labelEmpty.isHidden = true
                self?.galleryCollectionView.isHidden = false
            }
            self?.galleryCollectionView.reloadData()
        }
        .store(in: &cancellables)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.beers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = viewModel.beers[indexPath.row]
        let c = galleryCollectionView.dequeueReusableCell(withReuseIdentifier: "GalleryItemCollectionViewCell", for: indexPath) as! GalleryItemCollectionViewCell

        c.imageUrl = item.imageUrl
        return c
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = viewModel.beers[indexPath.row]
        delegate?.galleryViewControllerDidSelectElement(item)
    }
    
    // tasto cerca
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder() // chiude la testiera
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.search(text: searchText)
        
//        NetworkManager.shared.search(searchField.text!) { [weak self] result in
//            // metodo completion richiamato dal network manager
//            switch result {
//                case .success(let beers):
//                    if(beers.count == 0){
//                        self?.labelEmpty.isHidden = false
//                        self?.labelEmpty.text = "Nessun risultato"
//                        self?.galleryCollectionView.isHidden = true
//                    } else {
//                        self?.labelEmpty.isHidden = true
//                        self?.galleryCollectionView.isHidden = false
//                    }
//                    self?.items = beers
//                    self?.galleryCollectionView.reloadData()
//                case .failure(let error):
//                    self?.labelEmpty.isHidden = false
//                    self?.labelEmpty.text = "Errore nella chiamata"
//                    self?.galleryCollectionView.isHidden = true
//            }
//        }
    }
    

}
