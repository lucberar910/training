//
//  GalleryViewModel.swift
//  Training
//
//  Created by Diego Riccardi on 24/06/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import Combine

class GalleryViewModel: ViewModel {
    
    var searchUseCase : SearchUseCaseProtocol
    @Published var itemViewModels : [GalleryItemViewModel] = []
    
    init(container : MainContainerProtocol) {
        self.searchUseCase = container.searchUseCase
    }
    
    func search(text : String){
        self.searchUseCase.execute(text: text) { result in
            DispatchQueue.main.async {
                // thread principale
                switch result {
                    case .success(let beers):
                        self.itemViewModels = beers.map {return GalleryItemViewModel(beer: $0)}
                        
                    case .failure(let error):
                        ()
                }
            }
        }
    }

}
