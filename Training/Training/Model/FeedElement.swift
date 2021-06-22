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
