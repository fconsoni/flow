//
//  Result.swift
//  flow
//
//  Created by Usuario on 12/5/18.
//  Copyright © 2018 Consoni. All rights reserved.
//

import Foundation

class NamedError : NSError {
  static func say(domain: String = "", _ message: String) -> NSError {
    return NamedError(domain: domain, code: 0, userInfo: [NSLocalizedDescriptionKey: message])
  }
}

public enum Result<T> {
  case success(T)
  case failure(Error)
  
  init(_ f: @autoclosure () throws -> T) {
    do {
      self = .success(try f())
    } catch {
      self = .failure(error)
    }
  }
  
  init(_ error: Error) {
    self = .failure(error)
  }
  
  init(_ t: T?) {
    switch t {
    case .none: self = .failure(NamedError.say("Empty"))
    case .some(let some): self = .success(some)
    }
  }
  
  func get() throws -> T {
    switch self {
    case .success(let value):
      return value
    case .failure(let error):
      throw error
    }
  }
  
  func isSuccess() -> Bool {
    switch self {
    case .success(_):
      return true
    case _ :
      return false
    }
  }
  
  func map<U>(_ tx: (T) -> U) -> Result<U> {
    switch self {
    case .success(let value):
      return Result<U>.success(tx(value))
    case .failure(let error):
      return Result<U>.failure(error)
    }
  }
  
  public func flatMap<U>(_ transform: (T) throws -> U) -> Result<U> {
    switch self {
    case .success(let value): return try Result<U>(transform(value))
    case .failure(let error): return .failure(error)
    }
  }
  
  public func flatMap<U>(_ fx: (T) -> Result<U>) -> Result<U> {
    switch self {
    case .success(let value): return fx(value)
    case .failure(let error): return .failure(error)
    }
  }
  
  func getOrElse(_ defVal: T) -> T {
    switch self {
    case .success(let value): return value
    case .failure(_): return defVal
    }
  }
  
  func toOptional() -> Optional<T> {
    switch self {
    case .success(let value):
      return Optional(value)
    case .failure:
      return .none
    }
  }
  
  func fold<U>(_ ifError: U, _ tx : (T) -> U) -> U {
    return map(tx).getOrElse(ifError)
  }
  
  @discardableResult
  func onError(_ fx: (Error) -> Void) -> Result<T> {
    switch self {
    case .success:
      return self
    case .failure(let error):
      fx(error)
      return self
    }
  }
}

public func ==<T>(lhs: Result<T>, rhs: Result<T>) -> Bool {
  switch (lhs, rhs) {
  case (.success, .success): return true
  case (.failure, .failure): return true
  default: return false
  }
}
