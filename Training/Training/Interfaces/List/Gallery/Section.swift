//
//  Section.swift
//  Training
//
//  Created by Luca Berardinelli on 28/06/21.
//

import Foundation
class Section: Hashable {
  var id = UUID()
  var title: String
  var beers: [Beer]
  
  init(title: String, beers: [Beer]) {
    self.title = title
    self.beers = beers
  }
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
  
  static func == (lhs: Section, rhs: Section) -> Bool {
    lhs.id == rhs.id
  }
}
