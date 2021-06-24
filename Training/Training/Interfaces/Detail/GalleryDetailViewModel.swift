//
//  GalleryDetailViewModel.swift
//  Training
//
//  Created by Luca Berardinelli on 24/06/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import Combine

class GalleryDetailViewModel: ViewModel {
    
    var addFavUseCase : AddFavoriteUseCase
    var removeFavUseCase : RemoveFavoriteUseCase
    var isFavUseCase : IsFavoriteUseCase
    @Published var isFav : Bool
    private let beer : Beer
    var imageUrl : String? {
        beer.imageUrl
    }
    
    init(beer : Beer) {
        self.addFavUseCase = AddFavoriteUseCase()
        self.removeFavUseCase = RemoveFavoriteUseCase()
        self.isFavUseCase = IsFavoriteUseCase()
        self.beer = beer
        self.isFav = self.isFavUseCase.execute(id: beer.id)
    }
    
    func toggleFav(){
        if isFav {
            self.removeFavUseCase.execute(id: beer.id)
        } else {
            self.addFavUseCase.execute(id: beer.id)
        }
        isFav.toggle()
    }
    
}
