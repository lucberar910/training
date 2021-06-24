//
//  RemoveFavoriteUseCase.swift
//  Training
//
//  Created by Luca Berardinelli on 24/06/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import Combine

protocol RemoveFavoriteUseCaseProtocol {
    func execute(id : Int)
}

class RemoveFavoriteUseCase: RemoveFavoriteUseCaseProtocol {
    let repository = BeerRepository()
        
    func execute(id: Int) {
        self.repository.removeFav(id: id)
    }
}
