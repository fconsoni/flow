//
//  Collection.swift
//  flow
//
//  Created by Usuario on 12/6/18.
//  Copyright © 2018 Consoni. All rights reserved.
//

import Foundation

extension Collection {
  func all(_ condition: (Element) -> Bool) -> Bool {
    return self.filter(condition).count == self.count
  }
}

extension Array {
  func take(_ number: Int) -> [Element] {
    let index = Swift.min(number, self.count)
    return Array(self.prefix(through: index - 1))
  }
  
  func tail() -> [Element] {
    if self.isEmpty {
      return []
    } else {
      return Array(self.suffix(self.count - 1))
    }
  }
  
  func drop(_ number: Int) -> Array {
    return Array(self.dropLast(number))
  }
}
