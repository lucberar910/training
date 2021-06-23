//
//  GalleryDetailViewController.swift
//  Training
//
//  Created by Luca Berardinelli on 22/06/21.
//

import UIKit

class GalleryDetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView?
    var feedElement : Children?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        if let string = feedElement?.data.url {
            let url = URL(string: string)
            self.imageView!.kf.setImage(with: url, placeholder: UIImage(systemName: "pencil.and.outline"))
        } else {
            self.imageView!.image = nil
        }
        
    }

}
