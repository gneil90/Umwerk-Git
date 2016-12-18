//
//  Collection+UWKRandom.swift
//  
//
//  Created by Yan Saraev on 12/18/16.
//
//

import Foundation

public extension Array {  
  var randomItem: Element {
    let index = Int(arc4random_uniform(UInt32(self.count)))
    return self[index]
  }
}
