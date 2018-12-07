//
//  CityService.swift
//  flow
//
//  Created by Usuario on 12/7/18.
//  Copyright © 2018 Consoni. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class CountryService {
  private let url = "https://restcountries.eu/rest/v2/name/"
  private let event: (Result<[Country]>) -> Void
  
  init(onDataRecieved event: @escaping (Result<[Country]>) -> Void) {
    self.event = event
  }
  
  func getCountryList(withName name: String) {
    let completeUrl = url + "\(name)"
    
    Service(serverURL: completeUrl).hitUrlAndHandleWith(self.handler)
  }
  
  
  private func handler(_ data: DataResponse<Any>) {
    guard let response = data.response else {
      self.event(.failure(data.result.error!))
      return
    }
    
    if response.statusCode != 200 {
      self.event(.failure(NamedError.say("Country not found")))
      return
    }
    
    self.event(CountryParser.parse(JSON(data.result.value.getOrElse(""))))
  }
}
