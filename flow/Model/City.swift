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
  
  let weather: Weather?
  
  //Copy-method, traido desde Scala. Es la manera de aplicar record-syntax que existe en Haskell
  func copy(name: String? = nil, code: String? = nil, capitalCity: City? = nil, weather: Weather? = nil) -> Country {
    return Country.init(name: name.getOrElse(self.name),
                        code: code.getOrElse(self.code),
                        capitalCity: capitalCity.getOrElse(self.capitalCity),
                        weather: weather.fold(self.weather, identity))
  }
}
