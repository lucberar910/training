//
//  AddFavoriteUseCase.swift
//  Training
//
//  Created by Luca Berardinelli on 24/06/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import Combine

protocol AddFavoriteUseCaseProtocol {
    func execute(id: Int)
}

class AddFavoriteUseCase: AddFavoriteUseCaseProtocol {
    let repository : BeerRepositoryProtocol
    
    init(container : MainContainerProtocol) {
        self.repository = container.beersRepository
    }
        
    func execute(id: Int) {
        self.repository.addFav(id: id)
    }
}
