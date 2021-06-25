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
    var container = MainContainer()
    
    func start() {
        let galleyViewModel = GalleryViewModel(container: container)
        let galleryViewController = GalleryViewController(viewModel: galleyViewModel, delegate: self)
        navController.pushViewController(galleryViewController, animated: false)
    }
}

extension MainCoordinator: GalleryViewControllerDelegate {
    func galleryViewControllerDidSelectElement(_ selectedElement: Beer) {
        let galleryDetailViewModel = GalleryDetailViewModel(container: container, beer: selectedElement)
        let galleryDetailViewController = GalleryDetailViewController(viewModel: galleryDetailViewModel)
        //galleryDetailViewController.beer = selectedElement
        navController.pushViewController(galleryDetailViewController, animated: true)
    }
    
}
