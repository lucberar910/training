//
//  NetworkManager.swift
//  Training
//
//  Created by Luca Berardinelli on 23/06/21.
//

import Foundation
import Alamofire
import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    
    func search(_ text : String) {
        var request : String = "https://www.reddit.com/r/key_search/top.json"
        request = request.replacingOccurrences(of: "key_search", with: text)
        let params : [String : Any] = [:]
        
        AF.request(request)
            .validate(statusCode: 200..<300)
            .response {
                response in
                guard let data = response.data, response.error == nil else {
                    let a = UIAlertController(title: "Attenzione", message: "Errore nel recupero dei dati", preferredStyle: .alert)
                    a.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    //self.present(a, animated: true, completion: nil)
                    return
                }
                do {
                    var response : Reddit?
                    let decoder = JSONDecoder()
                    response = try decoder.decode(Reddit.self, from: data)
                    print(response)
                } catch let error {
                    print(error)
                }
            }
    }
}
