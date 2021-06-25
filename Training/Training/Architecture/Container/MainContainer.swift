//
//  MainContainer.swift
//  Training
//
//  Created by Luca Berardinelli on 25/06/21.
//

import Foundation

protocol MainContainerProtocol {
    var searchUseCase : SearchUseCaseProtocol { get }
    var addFavUseCase : AddFavoriteUseCaseProtocol { get }
    var removeFavUseCase : RemoveFavoriteUseCaseProtocol { get }
    var isFavUseCase : IsFavoriteUseCaseProtocol { get }
    var networkManager : NetworkManagerProtocol { get }
    var userDefaultsManager : UserDefaultManagerProtocol { get }
    var beersRepository : BeerRepositoryProtocol { get }
}

class MainContainer : Container, MainContainerProtocol {
   
    override init() {
        super.init()
        registerAll()
    }
    
    func registerAll(){
        register(type: SearchUseCaseProtocol.self) { (container:Container) in
            return SearchUseCase(container: container as! MainContainerProtocol)
        }
        register(type: RemoveFavoriteUseCaseProtocol.self) { (container:Container) in
            return RemoveFavoriteUseCase(container: container as! MainContainerProtocol)
        }
        register(type: AddFavoriteUseCaseProtocol.self) { (container:Container) in
            return AddFavoriteUseCase(container: container as! MainContainerProtocol)
        }
        register(type: IsFavoriteUseCaseProtocol.self) { (container:Container) in
            return IsFavoriteUseCase(container: container as! MainContainerProtocol)
        }
        register(type: NetworkManagerProtocol.self, mode: .lazily) { _ in
            return NetworkManager()
        }
        register(type: UserDefaultManagerProtocol.self, mode: .lazily) { _ in
            return UserDefaultManager()
        }
        register(type: BeerRepositoryProtocol.self, mode: .lazily) { (container:Container) in
            return BeerRepository(container: container as! MainContainerProtocol)
        }
    }
    
}

extension MainContainer {
    var searchUseCase: SearchUseCaseProtocol{
        resolve(type: SearchUseCaseProtocol.self)
    }
    var addFavUseCase: AddFavoriteUseCaseProtocol {
        resolve(type: AddFavoriteUseCaseProtocol.self)
    }
    var removeFavUseCase: RemoveFavoriteUseCaseProtocol {
        resolve(type: RemoveFavoriteUseCaseProtocol.self)
    }
    var isFavUseCase: IsFavoriteUseCaseProtocol {
        resolve(type: IsFavoriteUseCaseProtocol.self)
    }
    var networkManager: NetworkManagerProtocol {
        resolve(type: NetworkManagerProtocol.self)
    }
    var userDefaultsManager: UserDefaultManagerProtocol{
        resolve(type: UserDefaultManagerProtocol.self)
    }
    var beersRepository: BeerRepositoryProtocol {
        resolve(type: BeerRepositoryProtocol.self)
    }
}
