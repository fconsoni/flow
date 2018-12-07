//
//  CountryParser.swift
//  flow
//
//  Created by Usuario on 12/7/18.
//  Copyright © 2018 Consoni. All rights reserved.
//

import Foundation
import SwiftyJSON

class CountryParser {
  static func parse(_ json: JSON?) -> Result<[Country]> {
    guard let json = json else {
      return Result(NamedError.say("Empty JSON"))
    }
    
    let listOfJsonCountries = json.array.getOrElse([])
    
    return Result(listOfJsonCountries.map(createCountryFrom))
  }
  
  private static func createCountryFrom(_ json: JSON) -> Country {
    let city = City(name: (toString << getKeyFromJson("capital")) (json))
    
    return Country.init(name: (toString << getKeyFromJson("name")) (json),
                        code: (toString << getKeyFromJson("alpha2Code")) (json),
                        capitalCity: city,
                        weather: nil)
  }
}
