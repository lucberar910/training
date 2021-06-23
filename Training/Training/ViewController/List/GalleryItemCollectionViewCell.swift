//
//  GalleryItemCollectionViewCell.swift
//  Training
//
//  Created by Luca Berardinelli on 22/06/21.
//

import UIKit
import Kingfisher

class GalleryItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    private var downloadTask: DownloadTask?
    
    var imageUrl: String? {
        didSet {
            downloadTask?.cancel()
            downloadTask = nil
            
            if let urlString = imageUrl, let url = URL(string: urlString) {
                downloadTask = imageView.kf.setImage(with: url, placeholder: UIImage(systemName: "photo.on.rectangle.angled"))
            } else {
                imageView.image = nil
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
