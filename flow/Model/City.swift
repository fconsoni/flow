//
//  City.swift
//  flow
//
//  Created by Usuario on 12/5/18.
//  Copyright © 2018 Consoni. All rights reserved.
//

import Foundation

struct City {
  let name: String
}

struct Country {
  let name: String
  let code: String
  let capitalCity: City
}
