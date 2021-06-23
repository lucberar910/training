//
//  UserDefaultManager.swift
//  Training
//
//  Created by Diego Riccardi on 23/06/21.
//

import Foundation
import UIKit

class UserDefaultManager {
    
    static let shared = UserDefaultManager()
    
    var ids : [String] = []
    
    
    func addFav(id: String){
        if let data = UserDefaults.standard.data(forKey: "children"),
           let dataid = NSKeyedUnarchiver.unarchiveObject(with: data) {
                 self.ids.append(contentsOf: (dataid as! [String]))
        }
        self.ids.append(id)
    
        let encoded = NSKeyedArchiver.archivedData(withRootObject: self.ids)
                UserDefaults.standard.set(encoded, forKey: "children")
                UserDefaults.standard.synchronize()
    }
    
    func removeFav(id: String){
        if let data = UserDefaults.standard.data(forKey: "children"),
           let dataid = NSKeyedUnarchiver.unarchiveObject(with: data) {
                 self.ids.append(contentsOf: (dataid as! [String]))
        }
        
        while let idx = self.ids.index(of: id) {
            self.ids.remove(at: idx)
        }
    
        let encoded = NSKeyedArchiver.archivedData(withRootObject: self.ids)
                UserDefaults.standard.set(encoded, forKey: "children")
                UserDefaults.standard.synchronize()
        
        
    }
    
    func isFav(id: String) -> Bool {
        if let data = UserDefaults.standard.data(forKey: "children"),
           let dataid = NSKeyedUnarchiver.unarchiveObject(with: data) {
                 self.ids.append(contentsOf: (dataid as! [String]))
        }
        return self.ids.contains(id)
            
        }
    
    
         
    
    
    }
    
    

