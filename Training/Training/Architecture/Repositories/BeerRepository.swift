//
//  BeerRepository.swift
//  Training
//
//  Created by Diego Riccardi on 24/06/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import Combine

protocol BeerRepositoryProtocol {
    func search(_ text : String, completion : @escaping (Result<[Beer],Error>) -> Void)
    func addFav(id: Int)
    func removeFav(id: Int)
    func isFav(id: Int) -> Bool
}

public class BeerRepository{
    var network : NetworkManagerProtocol
    var userDefault : UserDefaultManagerProtocol
    
    init(container : MainContainerProtocol) {
        self.network = container.networkManager
        self.userDefault = container.userDefaultsManager
    }
}

extension BeerRepository: BeerRepositoryProtocol {
    
    func addFav(id: Int) {
        self.userDefault.addFav(id: id)
    }
    
    func removeFav(id: Int) {
        self.userDefault.removeFav(id: id)
    }
    
    func isFav(id: Int) -> Bool {
       return self.userDefault.isFav(id: id)
    }
    
    func search(_ text: String, completion: @escaping (Result<[Beer], Error>) -> Void) {
        self.network.search(text, completion: completion)
    }
}
