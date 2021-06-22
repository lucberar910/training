//
//  MockupData.swift
//  Training
//
//  Created by Luca Berardinelli on 22/06/21.
//

import Foundation
struct MockupData {
    static var feedElements : [FeedElement] = [
        FeedElement("juve", #imageLiteral(resourceName: "juve")),
        FeedElement("inter", #imageLiteral(resourceName: "inter")),
        FeedElement("milan", #imageLiteral(resourceName: "milan")),
        FeedElement("roma", #imageLiteral(resourceName: "roma"))
    ]
    
    static func getData() -> [FeedElement] {
        return self.feedElements
    }
}
