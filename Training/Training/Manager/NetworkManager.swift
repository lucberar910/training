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
    
    func search(_ text : String, completion : @escaping (Result<Reddit,Error>) -> Void) {
        var request : String = "https://www.reddit.com/r/key_search/top.json"
        request = request.replacingOccurrences(of: "key_search", with: text)
        
        AF.request(request)
            .validate(statusCode: 200..<300)
            .response {
                response in
                guard let data = response.data, response.error == nil else {
                    completion(Result.failure(response.error as! Error))
                    return
                }
                do {
                    var response : Reddit?
                    let decoder = JSONDecoder()
                    response = try decoder.decode(Reddit.self, from: data)
                    completion(Result.success(response!))
//                    completion(Result.failure(URLError(URLError.badServerResponse)))
                } catch let error {
                    completion(Result.failure(error))
                }
            }
    }
}
