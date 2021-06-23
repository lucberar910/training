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
        FeedElement("roma", #imageLiteral(resourceName: "roma")),
        FeedElement("fiorentina", #imageLiteral(resourceName: "fiorentina")),
        FeedElement("atalanta", #imageLiteral(resourceName: "atalanta")),
        FeedElement("lazio", #imageLiteral(resourceName: "lazio")),
        FeedElement("bologna", #imageLiteral(resourceName: "bologna")),
        FeedElement("cagliari", #imageLiteral(resourceName: "cagliari")),
        FeedElement("genoa", #imageLiteral(resourceName: "genoa")),
        FeedElement("napoli", #imageLiteral(resourceName: "napoli")),
        FeedElement("sampdoria", #imageLiteral(resourceName: "sampdoria")),
        FeedElement("torino", #imageLiteral(resourceName: "torino")),
        FeedElement("udinese", #imageLiteral(resourceName: "udinese"))
    ]
    
    static func getData() -> [FeedElement] {
        return self.feedElements
    }
}
