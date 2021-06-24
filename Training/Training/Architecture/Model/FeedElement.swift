//
//  FeedElement.swift
//  Training
//
//  Created by Luca Berardinelli on 22/06/21.
//

import Foundation
import UIKit

struct FeedElement {
    let title : String
    let image : UIImage

    init(_ title : String, _ image : UIImage) {
        self.title = title
        self.image = image
    }
}

struct Reddit : Decodable {
    var data : DataMain
}

struct DataMain : Decodable {
    var children : [Children]
}

struct Children : Decodable {
    var data : Data
}

struct Data : Decodable {
    var name : String
    var thumbnail : String
    var url : String
}
