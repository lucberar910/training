//
//  GalleryItemViewModel.swift
//  Training
//
//  Created by Luca Berardinelli on 25/06/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import Combine

class GalleryItemViewModel: ViewModel {
    let beer : Beer
    var imageUrl : String? {
        beer.imageUrl
    }
    
    init(beer : Beer) {
        self.beer = beer
    }
}