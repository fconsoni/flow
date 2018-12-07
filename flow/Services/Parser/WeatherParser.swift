//
//  WeatherParser.swift
//  flow
//
//  Created by Usuario on 12/6/18.
//  Copyright © 2018 Consoni. All rights reserved.
//

import Foundation
import SwiftyJSON

//La aplicacion del paradigma funcional es muy util en un parser
//Funciones currificadas, aplicacion parcial, y composicion de funciones
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
    return City(name: (toString << (getKeyFromJson("name") << getKeyFromJson("city")))(json))
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
