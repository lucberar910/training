//
//  MainContainer.swift
//  Training
//
//  Created by Luca Berardinelli on 25/06/21.
//

import Foundation

protocol MainContainerProtocol {
    var searchUseCase : SearchUseCaseProtocol { get }
}

class MainContainer : Container, MainContainerProtocol {
   
    override init() {
        super.init()
        registerAll()
    }
    
    func registerAll(){
        register(type: SearchUseCaseProtocol.self) { _ in
            return SearchUseCase()
        }
    }
    
}

extension MainContainer {
    var searchUseCase: SearchUseCaseProtocol{
        resolve(type: SearchUseCaseProtocol.self)
    }
}
