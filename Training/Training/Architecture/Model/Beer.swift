//
//  Beer.swift
//  Training
//
//  Created by Paolo Ardia on 23/06/21.
//

import Foundation

struct Beer: Decodable, Hashable {
    let id: Int
    let imageUrl: String?
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case imageUrl = "image_url"
        case name
    }
    
    func hash(into hasher: inout Hasher) {
      // 2
      hasher.combine(id)
    }
    // 3
    static func == (lhs: Beer, rhs: Beer) -> Bool {
      lhs.id == rhs.id
    }
}
