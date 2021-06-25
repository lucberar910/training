//
//  GalleryItemCollectionViewCell.swift
//  Training
//
//  Created by Luca Berardinelli on 22/06/21.
//

import UIKit
import Kingfisher

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
    
    @IBOutlet weak var imageView: UIImageView!
    private var downloadTask : DownloadTask?
    var imageUrl : String?
   
    
//    init(viewModel : GalleryItemViewModel) {
//        self.viewModel = viewModel
//        //super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
