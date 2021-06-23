//
//  MainCoordinator.swift
//  Training
//
//  Created by Luca Berardinelli on 22/06/21.
//

import Foundation
import UIKit

class MainCoordinator : Coordinator {
    var navController : UINavigationController = UINavigationController()
    
    func start() {
        let galleryViewController = GalleryViewController()
        navController.pushViewController(galleryViewController, animated: false)
        galleryViewController.delegate = self
    }
}

extension MainCoordinator: GalleryViewControllerDelegate {
    func galleryViewControllerDidSelectElement(_ selectedElement: Beer) {
        let galleryDetailViewController = GalleryDetailViewController()
        galleryDetailViewController.beer = selectedElement
        navController.pushViewController(galleryDetailViewController, animated: true)
    }
    
}
