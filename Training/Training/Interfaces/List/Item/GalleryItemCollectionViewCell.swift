//
//  GalleryItemCollectionViewCell.swift
//  Training
//
//  Created by Luca Berardinelli on 22/06/21.
//

import UIKit
import Kingfisher
import Anchorage

class GalleryItemCollectionViewCell: UICollectionViewCell {

    typealias ViewModelType = GalleryItemViewModel
    var viewModel : GalleryItemViewModel? {
        didSet {
            downloadTask?.cancel()
            downloadTask = nil
            if let string = self.viewModel?.imageUrl {
                let url = URL(string: string)
                downloadTask = imageView.kf.setImage(with: url, placeholder: UIImage(systemName: "photo.on.rectangle.angled"))
            } else {
                imageView.image = nil
            }
        }
    }
    
    // MARK: - UI properties
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private var downloadTask : DownloadTask?
    var imageUrl : String?
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configure methods
    
    func configureUI() {
        contentView.addSubview(imageView)
    }
    
    func configureConstraints() {
        imageView.edgeAnchors == contentView.edgeAnchors
    }
}
