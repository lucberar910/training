//
//  GalleryViewController.swift
//  Training
//
//  Created by Luca Berardinelli on 22/06/21.
//

import UIKit
import Kingfisher
import Combine
import Anchorage

protocol GalleryViewControllerDelegate: AnyObject {
    func galleryViewControllerDidSelectElement(_ selectedElement: Beer)
}

class GalleryViewController: UIViewController, ViewModellable {
    
    typealias ViewModelType = GalleryViewModel
    var viewModel: GalleryViewModel
    weak var delegate: GalleryViewControllerDelegate?
    var cancellables = Set<AnyCancellable>()
    
    // MARK: - UI properties
    
    private let galleryCollectionView: UICollectionView = {
        // ------ LAYOUT ----- //
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
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        // ------ END LAYOUT ------ //
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.darkGray
        collectionView.layer.cornerRadius = 20
        collectionView.layer.masksToBounds = true
        return collectionView
    }()
    
    private let searchField = UISearchBar()
    
    private let labelEmpty: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = UIColor.label
        return label
    }()
    
    // MARK: - Object lifecycle
    
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
        configureUI()
        configureConstraints()
        // subscriber
        bindViewModel()
    }
    
    // MARK: - Bind methods
    
    func bindViewModel(){
        viewModel.$itemViewModels 
            .receive(on: RunLoop.main)
            .sink { [weak self] items in
            if(items.count == 0){
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
    
    // MARK: - Configure methods
    
    func configureUI() {
        view.backgroundColor = UIColor.white
        // galleryCollectionView
        self.galleryCollectionView.dataSource = self
        self.galleryCollectionView.delegate = self
        // supplementary item (banner sopra gli item)
        self.galleryCollectionView.register(UINib(nibName: "NewBannerSupplementaryView", bundle: nil), forSupplementaryViewOfKind: "new-banner", withReuseIdentifier: "NewBannerSupplementaryView")
        // cell
        self.galleryCollectionView.register(GalleryItemCollectionViewCell.self, forCellWithReuseIdentifier: "GalleryItemCollectionViewCell")
        view.addSubview(galleryCollectionView)
        
        // searchField
        self.searchField.delegate = self
        view.addSubview(searchField)
        
        // labelEmpty
        view.addSubview(labelEmpty)
    }
    
    func configureConstraints() {
        // searchField
        searchField.topAnchor == view.safeAreaLayoutGuide.topAnchor
        searchField.horizontalAnchors == view.horizontalAnchors
        searchField.heightAnchor == 51
        
        // galleryCollectionView
        galleryCollectionView.topAnchor == searchField.bottomAnchor
        galleryCollectionView.horizontalAnchors == view.horizontalAnchors
        galleryCollectionView.bottomAnchor == view.bottomAnchor
        
        // labelEmpty
        labelEmpty.horizontalAnchors == view.horizontalAnchors + 32
        labelEmpty.centerYAnchor == view.centerYAnchor
    }
}



// MARK: - UICollectionViewDelegate & UICollectionViewDataSource
extension GalleryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.itemViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = viewModel.itemViewModels[indexPath.row]
        let c = galleryCollectionView.dequeueReusableCell(withReuseIdentifier: "GalleryItemCollectionViewCell", for: indexPath) as! GalleryItemCollectionViewCell
        
        c.viewModel = item //.init(beer: item) .init di GalleryItemViewModel
//        c.imageUrl = item.imageUrl
        return c
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = viewModel.itemViewModels[indexPath.row]
        delegate?.galleryViewControllerDidSelectElement(item.beer)
    }
}


// MARK: - UISearchBarDelegate
extension GalleryViewController: UISearchBarDelegate {
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
