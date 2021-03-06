//
//  GalleryDetailViewController.swift
//  Training
//
//  Created by Luca Berardinelli on 22/06/21.
//

import UIKit
import Kingfisher
import Combine
import Anchorage

class GalleryDetailViewController: UIViewController, UIScrollViewDelegate, ViewModellable {
    typealias ViewModelType = GalleryDetailViewModel
    var viewModel: GalleryDetailViewModel
    
    @IBOutlet weak var scrollView: UIScrollView!
   // @IBOutlet weak var imageView: UIImageView!
    var cancellables = Set<AnyCancellable>()
    
    var btn = UIBarButtonItem(
        image: UIImage(systemName: "star"),
        style: .plain,
        target: nil,
        action: nil)
    
    
    // MARK: - Object lifecycle
    
    init(viewModel : GalleryDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func pressBtn(sender: UIBarButtonItem) {
        viewModel.toggleFav()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.scrollView.delegate = self
//        self.scrollView.minimumZoomScale = 1
//        self.scrollView.zoomScale = 1
//        self.scrollView.maximumZoomScale = 2
        
        self.btn.target = self
        self.btn.action = #selector(pressBtn(sender:))
        self.navigationItem.rightBarButtonItem = btn
        bindViewModel()
    
        configureUI()
        configureConstraints()
    }
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: - Configure methods
    
    func configureUI(){
        view.addSubview(imageView)
    }
    
    func configureConstraints(){
        // imageView
        imageView.verticalAnchors >= view.safeAreaLayoutGuide.verticalAnchors + 20
        imageView.centerYAnchor == view.safeAreaLayoutGuide.centerYAnchor 
        imageView.leadingAnchor == view.leadingAnchor
        imageView.trailingAnchor == view.trailingAnchor
    }
    
    // MARK: - Bind methods
    
    func bindViewModel(){
        viewModel.$isFav.sink { [weak self] value in
            if value {
                self?.btn.image = UIImage(systemName: "star.fill")
            } else {
                self?.btn.image = UIImage(systemName: "star")
            }
        }.store(in: &cancellables)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let string = viewModel.imageUrl {
            let url = URL(string: string)
            self.imageView.kf.setImage(with: url, placeholder: UIImage(systemName: "photo.on.rectangle.angled"), options: [.imageModifier(ResizeModifier(maxHeight: imageView.bounds.height))])
        } else {
            self.imageView.image = nil
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }

}

struct ResizeModifier: ImageModifier {
    let maxHeight: CGFloat
    
    init(maxHeight: CGFloat) {
        self.maxHeight = maxHeight
    }
    
    func modify(_ image: KFCrossPlatformImage) -> KFCrossPlatformImage {
        guard let resizedImage = image.resizeWithHeight(height: maxHeight) else { return image }
        return resizedImage
    }
}

extension UIImage {
    
    func resizeWithHeight(height: CGFloat) -> UIImage? {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: CGFloat(ceil(size.width * height/size.height)), height: height)))
        imageView.contentMode = .scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return result
    }
}
