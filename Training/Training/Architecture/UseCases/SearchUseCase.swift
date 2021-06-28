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
//     func execute(text: String, completion: @escaping (Result<[Beer], Error>) -> Void)
    func execute(text: String) -> AnyPublisher<[Beer],Error>
}

class SearchUseCase: SearchUseCaseProtocol {
    let repository : BeerRepositoryProtocol
    
    init(container : MainContainerProtocol) {
        self.repository = container.beersRepository
    }
    
   // func execute(text: String, completion: @escaping (Result<[Beer], Error>) -> Void) {
    func execute(text: String) -> AnyPublisher<[Beer],Error> {
        self.repository.search(text)
    }
}
