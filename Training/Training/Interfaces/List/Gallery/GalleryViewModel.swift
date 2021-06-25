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
    var cancellables = Set<AnyCancellable>()
    
    init(container : MainContainerProtocol) {
        self.searchUseCase = container.searchUseCase
    }
    
    func search(text : String){
        self.searchUseCase.execute(text: text)
            .receive(on: RunLoop.main)
            .map{ beers in
                let items = beers.map{ beer -> GalleryItemViewModel in
                    let item = GalleryItemViewModel(beer: beer)
                    return item
                }
                return items
            }
            .sink(receiveCompletion: { completion in
                
            }, receiveValue: { items in
                self.itemViewModels = items
                
            }).store(in: &cancellables)
        
        
        
    }

}
