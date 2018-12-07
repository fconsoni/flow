//
//  Weather.swift
//  flow
//
//  Created by Usuario on 12/5/18.
//  Copyright © 2018 Consoni. All rights reserved.
//

import Foundation

struct Weather {
  struct Forecast {
    let minTemp: Int
    let maxTemp: Int
    let cloudPercent: Int
    let date: Date
  }
  
  let city: City
  let actual: Forecast
  let nextDaysForecast: [Forecast]
}
