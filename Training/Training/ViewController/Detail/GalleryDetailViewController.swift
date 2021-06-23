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
    
    var isFavorite: Bool = false {
        didSet {
            if isFavorite {
                btn.image = UIImage(systemName: "star.fill")
            } else {
                btn.image = UIImage(systemName: "star")
            }
        }
    }
    
    
    
    
    
    var btn = UIBarButtonItem(
        image: UIImage(systemName: "star"),
        style: .plain,
        target: nil,
        action: nil)
    
    
    @objc func pressBtn(sender: UIBarButtonItem) {
        if isFavorite {
            UserDefaultManager.shared.removeFav(id: feedElement!.data.name)
            
            
        } else {
            UserDefaultManager.shared.addFav(id: feedElement!.data.name)
        }
        isFavorite.toggle()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.scrollView.delegate = self
//        self.scrollView.minimumZoomScale = 0.01
//        self.scrollView.zoomScale = 0.25
//        self.scrollView.maximumZoomScale = 2
        
        isFavorite = UserDefaultManager.shared.isFav(id: feedElement!.data.name)
        print("-----------\(isFavorite)")
        self.btn.target = self
        self.btn.action = #selector(pressBtn(sender:))
    
        self.navigationItem.rightBarButtonItem = btn
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
