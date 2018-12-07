//
//  ParserFunctions.swift
//  flow
//
//  Created by Usuario on 12/7/18.
//  Copyright © 2018 Consoni. All rights reserved.
//

import Foundation
import SwiftyJSON

func getFrom(_ json: JSON?, key: String) -> JSON? {
  return (json.flatMap{ $0.dictionary }.getOrElse([:]))[key]
}

func toString(_ json: JSON?) -> String {
  return json.flatMap{ $0.string }.getOrElse("EMPTY")
}

func toInt(_ json: JSON?) -> Int {
  return json.flatMap{ $0.int }.getOrElse(0)
}

func toList(_ json: JSON?) -> [JSON] {
  return json.flatMap{ $0.array }.getOrElse([])
}

func toDate(_ json: JSON?) -> Date {
  let formatter = DateFormatter()
  formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssz"
  
  return ((formatter.date(from:) << ({ $0.words().joined(separator: "T") + "+0000" } << toString))(json)).getOrElse(Date())
}

let getKeyFromJson = curry(flip(getFrom))
