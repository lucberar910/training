//
//  SearchUseCase.swift
//  Training
//
//  Created by Diego Riccardi on 24/06/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import Combine

protocol SearchUseCaseProtocol {
    func execute(text: String, completion: @escaping (Result<[Beer], Error>) -> Void)
}

class SearchUseCase: SearchUseCaseProtocol {
    let repository = BeerRepository()
    
    func execute(text: String, completion: @escaping (Result<[Beer], Error>) -> Void) {
        self.repository.search(text, completion: completion)
    }
}
