//
//  Weather.swift
//  flow
//
//  Created by Usuario on 12/5/18.
//  Copyright © 2018 Consoni. All rights reserved.
//

import UIKit

enum Icon {
  case clear
  case scattered
  case clouds
  case rain
  
  func getIcon() -> UIImage {
    switch self {
    case .clear: return #imageLiteral(resourceName: "clear")
    case .scattered: return #imageLiteral(resourceName: "scattered")
    case .clouds: return #imageLiteral(resourceName: "clouds")
    case .rain: return #imageLiteral(resourceName: "rain")
    }
  }
}

struct Weather {
  struct Forecast {
    let temp: Int
    let cloudPercent: Int
    let date: Date
    let icon: Icon
    
    func getIcon() -> UIImage {
      return icon.getIcon()
    }
  }
  
  let city: City
  let actual: Forecast
  let nextDaysForecast: [Forecast]
  
  func getActualIcon() -> UIImage {
    return self.actual.getIcon()
  }
}
