//
//  Optional.swift
//  flow
//
//  Created by Usuario on 12/5/18.
//  Copyright © 2018 Consoni. All rights reserved.
//

import Foundation

extension Optional {
  func get(_ error: Error? = nil) throws -> Wrapped {
    switch self {
    case .none:
      throw error ?? NSError(domain: "No wrapped value: \(String(describing: self))", code: 0, userInfo: nil)
    case .some(let some): return some
    }
  }
  
  func filter(_ fx: (Wrapped) -> Bool) -> Optional {
    switch self {
    case .none: return self
    case .some(let some): return fx(some) ? self : .none
    }
  }
  
  func isEmpty() -> Bool {
    switch self {
    case .some(_): return false
    case .none: return true
    }
  }
  
  func fold<U>(_ ifEmpty: U, _ tx : (Wrapped) -> U) -> U {
    switch self {
    case .some(let value): return tx(value)
    case .none: return ifEmpty
    }
  }
  
  func getOrElse(_ ifEmpty: Wrapped) -> Wrapped {
    switch self {
    case .some(let value): return value
    case .none: return ifEmpty
    }
  }
}
