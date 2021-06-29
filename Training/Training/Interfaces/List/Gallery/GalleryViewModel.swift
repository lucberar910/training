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
    @Published var selectedBeer : Beer?
    var cancellables = Set<AnyCancellable>()
    
    init(container : MainContainerProtocol) {
        self.searchUseCase = container.searchUseCase
    }
    
    //  --- combine
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
    
    func didSelectBeer(indexPath: IndexPath){
        let item = itemViewModels[indexPath.row]
        self.selectedBeer = item.beer
    }

    
//    --- closure
//    func search(text : String){
//        self.searchUseCase.execute(text: text) { result in
//            DispatchQueue.main.async {
//                // thread principale
//                switch result {
//                    case .success(let beers):
//                        self.itemViewModels = beers.map {return GalleryItemViewModel(beer: $0)}
//                        
//                    case .failure(let error):
//                        ()
//                }
//            }
//        }
    
}
