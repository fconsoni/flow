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

extension String {
  func lines() -> [String] {
    return separateBy("\n")
  }
  
  func words() -> [String] {
    return separateBy(" ")
  }
  
  private func separateBy(_ separator: String) -> [String] {
    return self.components(separatedBy: CharacterSet(charactersIn: separator))
  }
  
  func trim() -> String {
    return self.trimmingCharacters(in: CharacterSet.whitespaces)
  }
  
  func take(_ number: Int) -> String {
    let index = Swift.min(number, self.count)
    return String(self.prefix(through: .init(encodedOffset: (index - 1))))
  }
  
  func tail() -> String {
    if self.isEmpty {
      return ""
    } else {
      return String(self.suffix(self.count - 1))
    }
  }
  
  func drop(_ number: Int) -> String {
    return String(self.dropLast(number))
  }
}
