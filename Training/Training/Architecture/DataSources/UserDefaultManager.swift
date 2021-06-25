//
//  UserDefaultManager.swift
//  Training
//
//  Created by Diego Riccardi on 23/06/21.
//

import Foundation
import UIKit

protocol UserDefaultManagerProtocol {
    func addFav(id: Int)
    func removeFav(id: Int)
    func isFav(id: Int) -> Bool
}

class UserDefaultManager : UserDefaultManagerProtocol {
    
   // static let shared = UserDefaultManager()

    func addFav(id: Int){
        var ids = UserDefaults.standard.object(forKey: "beers") as? [Int] ?? [Int]()
        ids.append(id)
    
        UserDefaults.standard.set(ids, forKey: "beers")
        UserDefaults.standard.synchronize()
    }
    
    func removeFav(id: Int) {
        var ids = UserDefaults.standard.object(forKey: "beers") as? [Int] ?? [Int]()
        ids.removeAll(where: { $0 == id })
    
        UserDefaults.standard.set(ids, forKey: "beers")
        UserDefaults.standard.synchronize()
    }
    
    func isFav(id: Int) -> Bool {
        var ids = UserDefaults.standard.object(forKey: "beers") as? [Int] ?? [Int]()
        return ids.contains(id)
    }
}
