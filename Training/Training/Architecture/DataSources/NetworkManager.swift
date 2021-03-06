//
//  NetworkManager.swift
//  Training
//
//  Created by Luca Berardinelli on 23/06/21.
//

import Foundation
import Alamofire
import UIKit
import Combine

protocol NetworkManagerProtocol {
//  --- combine
    func search(_ text : String) -> AnyPublisher<[Beer],Error>
//  --- closure
//  func search(_ text : String, completion : @escaping (Result<[Beer],Error>) -> Void)
}

class NetworkManager : NetworkManagerProtocol {
   // static let shared = NetworkManager()
    var currentRequest : DataRequest?
   
//  --- COMBINE
    func search(_ text : String) -> AnyPublisher<[Beer],Error> {
        currentRequest?.cancel()
        let request : String = "https://api.punkapi.com/v2/beers?page=1&per_page=80&beer_name=\(text.replacingOccurrences(of: " ", with: "_"))"
        
        currentRequest = AF.request(request)
        return Future<[Beer], Error> { promise in
            self.currentRequest!
                .validate(statusCode: 200..<300)
                .response {
                    response in
                    guard let data = response.data, response.error == nil else {
                        promise(.failure(response.error!))
                        return
                    }
                    do {
                        var response : [Beer]?
                        let decoder = JSONDecoder()
                        response = try decoder.decode([Beer].self, from: data)
                        promise(.success(response!))
                    } catch let error {
                        promise(.failure(error))
                    }
                    
                    
                }
        }.eraseToAnyPublisher()
    }
    
    //    --- CLOSURE
    //    func search(_ text : String, completion : @escaping (Result<[Beer],Error>) -> Void) {
    //        currentRequest?.cancel()
    //        let request : String = "https://api.punkapi.com/v2/beers?page=1&per_page=80&beer_name=\(text.replacingOccurrences(of: " ", with: "_"))"
    //
    //        currentRequest = AF.request(request)
    //            .validate(statusCode: 200..<300)
    //            .response {
    //                response in
    //                guard let data = response.data, response.error == nil else {
    //                    completion(Result.failure(response.error!))
    //                    return
    //                }
    //                do {
    //                    var response : [Beer]?
    //                    let decoder = JSONDecoder()
    //                    response = try decoder.decode([Beer].self, from: data)
    //                    completion(Result.success(response!))
    ////                    completion(Result.failure(URLError(URLError.badServerResponse)))
    //                } catch let error {
    //                    completion(Result.failure(error))
    //                }
    //            }
    //    }

}

