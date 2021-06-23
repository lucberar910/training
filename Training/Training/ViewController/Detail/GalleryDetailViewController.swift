//
//  GalleryDetailViewController.swift
//  Training
//
//  Created by Luca Berardinelli on 22/06/21.
//

import UIKit

class GalleryDetailViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView?
    var feedElement : Children?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView.delegate = self
    
        if let string = feedElement?.data.url {
            let url = URL(string: string)
            self.imageView!.kf.setImage(with: url, placeholder: UIImage(systemName: "pencil.and.outline"))
        } else {
            self.imageView!.image = nil
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    

}
