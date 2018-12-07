//
//  WeatherParser.swift
//  flow
//
//  Created by Usuario on 12/6/18.
//  Copyright © 2018 Consoni. All rights reserved.
//

import Foundation
import SwiftyJSON

//Una aplicacion del paradigma funcional es muy util en parser
class WeatherParser {
  static func parse(_ json: JSON?) -> Result<Weather> {
    guard let json = json else {
      return Result(NamedError.say("Empty JSON"))
    }
    
    let city = getCityFrom(json)
    let forecasts = ({ $0.filter(isDailyForecast).take(4) } << ({ $0.map(getForecastFrom) } << (toList << getKeyFromJson("list"))))(json)
    
    if forecasts.isEmpty {
      return Result(NamedError.say("Empty JSON"))
    }
    
    return Result(Weather(city: city,
                   actual: forecasts.first!,
                   nextDaysForecast: forecasts.tail())
    )
  }
  
  private static func getCityFrom(_ json: JSON) -> City {
    //Un ejemplo de programacion funcional: es una composicion de funciones, de misma lectura que Haskell
    return City(name: (toString << (getKeyFromJson("name") << getKeyFromJson("city")))(json),
                countryCode: (toString << (getKeyFromJson("country") << getKeyFromJson("city")))(json))
  }
  
  private static func getForecastFrom(_ json: JSON) -> Weather.Forecast {
    return Weather.Forecast.init(minTemp: (toInt << (getKeyFromJson("temp_min") << getKeyFromJson("main")))(json),
                                 maxTemp: (toInt << (getKeyFromJson("temp_max") << getKeyFromJson("main")))(json),
                                 cloudPercent: (toInt << (getKeyFromJson("all") << getKeyFromJson("clouds")))(json),
                                 date: (toDate << getKeyFromJson("dt_txt"))(json))
  }
  
  private static func isDailyForecast(_ forecast: Weather.Forecast) -> Bool {
    let date = forecast.date
    let calendar = Calendar.current
    let hour = calendar.component(.hour, from: date)
    
    return hour == 6
  }
}

private func getFrom(_ json: JSON?, key: String) -> JSON? {
  return (json.flatMap{ $0.dictionary }.getOrElse([:]))[key]
}

private func toString(_ json: JSON?) -> String {
  return json.flatMap{ $0.string }.getOrElse("EMPTY")
}

private func toInt(_ json: JSON?) -> Int {
  return json.flatMap{ $0.int }.getOrElse(0)
}

private func toList(_ json: JSON?) -> [JSON] {
  return json.flatMap{ $0.array }.getOrElse([])
}

private func toDate(_ json: JSON?) -> Date {
  let formatter = DateFormatter()
  formatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
  
  return ((formatter.date(from:) << toString)(json)).getOrElse(Date())
}

private let getKeyFromJson = curry(flip(getFrom))
