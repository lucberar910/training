//
//  GalleryDetailViewController.swift
//  Training
//
//  Created by Luca Berardinelli on 22/06/21.
//

import UIKit

class GalleryDetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView?
    var feedElement : FeedElement? 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView?.image = feedElement?.image
    }

}
