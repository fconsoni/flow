//
//  WeatherService.swift
//  flow
//
//  Created by Usuario on 12/5/18.
//  Copyright © 2018 Consoni. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class WeatherService {
  private let apiKey = "de73edde69e975f23146f18d77bb1710"
  private let url = "http://api.openweathermap.org/data/2.5/forecast?"
  private let event: (Result<Weather>) -> Void 
  
  init(onDataRecieved event: @escaping (Result<Weather>) -> Void) {
    self.event = event
  }
  
  func getForecastFor(cityName: String, countryCode: String) {
    let completeUrl = url + "q=\(cityName),\(countryCode)&units=metric" + self.getApiKeyParam()
    
    Service(serverURL: completeUrl).hitUrlAndHandleWith(self.handler)
  }
  
  
  
  private func getApiKeyParam() -> String {
    return "&APPID=" + apiKey
  }
  
  private func handler(_ data: DataResponse<Any>) {
    guard let response = data.response else {
      self.event(.failure(data.result.error!))
      return
    }

    if response.statusCode != 200 {
      return
    }

    self.event(WeatherParser.parse(JSON(data.result.value.getOrElse(""))))
  }
}
