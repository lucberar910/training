//
//  Beer.swift
//  Training
//
//  Created by Paolo Ardia on 23/06/21.
//

import Foundation

struct Beer: Decodable {
    let id: Int
    let imageUrl: String?
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case imageUrl = "image_url"
        case name
    }
}
