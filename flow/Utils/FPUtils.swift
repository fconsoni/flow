//
//  FPUtils.swift
//  flow
//
//  Created by Usuario on 12/6/18.
//  Copyright © 2018 Consoni. All rights reserved.
//

import Foundation

func identity<T>(_ any: T) -> T {
  return any
}

func curry<A,B,R>(_ f: @escaping (A, B) -> R) -> (A) -> (B) -> (R) {
  return { a in { b in f(a,b) } }
}

func curry<A,B,C,R>(_ f: @escaping (A, B, C) -> R) -> (A) -> (B) -> (C) -> (R) {
  return { a in { b in { c in f(a,b,c) } } }
}

func curry<A,B,C,D,R>(_ f: @escaping (A, B, C, D) -> R) -> (A) -> (B) -> (C) -> (D) -> (R) {
  return { a in { b in { c in { d in f(a,b,c,d) } } } }
}

func curry<A,B,C,D,E,R>(_ f: @escaping (A, B, C, D, E) -> R) -> (A) -> (B) -> (C) -> (D) -> (E) -> (R) {
  return { a in { b in { c in { d in { e in f(a,b,c,d,e) } } } } }
}

func curry<A,B,C,D,E,F,R>(_ fx: @escaping (A, B, C, D, E, F) -> R) -> (A) -> (B) -> (C) -> (D) -> (E) -> (F) -> (R) {
  return { a in { b in { c in { d in { e in { f in fx(a,b,c,d,e,f) } } } } } }
}

func flip<A,B,C>(_ f: @escaping (A, B) -> C) -> (B, A) -> C {
  func mask(_ b: B, _ a: A) -> C {
    return f(a,b)
  }
  return mask
}

precedencegroup CompositionPrecedence {
  associativity: right
  higherThan: BitwiseShiftPrecedence
}

infix operator << : CompositionPrecedence
func << <T,U,V>(_ f: @escaping (U) -> V, _ g: @escaping (T) -> U) -> (T) -> V {
  return { f(g($0)) }
}

func nop() {}
func nop<T>(_ t: T) {}
