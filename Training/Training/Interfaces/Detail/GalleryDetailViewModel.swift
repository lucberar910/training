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
    
    var addFavUseCase : AddFavoriteUseCaseProtocol
    var removeFavUseCase : RemoveFavoriteUseCaseProtocol
    var isFavUseCase : IsFavoriteUseCaseProtocol
    
    @Published var isFav : Bool
    private let beer : Beer
    var imageUrl : String? {
        beer.imageUrl
    }
    
    init(container : MainContainerProtocol, beer : Beer) {
        self.addFavUseCase = container.addFavUseCase // AddFavoriteUseCase()
        self.removeFavUseCase = container.removeFavUseCase // RemoveFavoriteUseCase()
        self.isFavUseCase = container.isFavUseCase // IsFavoriteUseCase()
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
