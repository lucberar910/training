//
//  IsFavoriteUseCase.swift
//  Training
//
//  Created by Luca Berardinelli on 24/06/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import Combine

protocol IsFavoriteUseCaseProtocol {
    func execute(id : Int) -> Bool
}

class IsFavoriteUseCase: IsFavoriteUseCaseProtocol {
    let repository : BeerRepositoryProtocol
    
    init(container : MainContainerProtocol) {
        self.repository = container.beersRepository
    }
        
    func execute(id: Int) -> Bool {
       return self.repository.isFav(id: id)
    }
}
