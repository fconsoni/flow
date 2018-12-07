//
//  RestService.swift
//  flow
//
//  Created by Usuario on 12/5/18.
//  Copyright © 2018 Consoni. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class Report {
  private var string: String = ""
  init() {
    self.print("===================\n")
  }
  func print(_ s: String) {
    string = string.appending("\(s)\n")
  }
  func close() {
    self.print("===================\n")
    Swift.print(string)
  }
}

class Service {
  private var serverURL: String
  
  init(serverURL: String) {
    self.serverURL = serverURL
    
    let configuration = URLSessionConfiguration.default
    configuration.timeoutIntervalForRequest = 10 // seconds
    configuration.timeoutIntervalForResource = 10
    _ = Alamofire.SessionManager(configuration: configuration)
  }
  
  func hitUrlAndHandleWith(_ handler: @escaping (DataResponse<Any>) -> Void) {
    _ = Alamofire.request(self.serverURL).responseJSON(completionHandler: recieveDataWith(handler))
  }
  
  private func recieveDataWith(_ handler: @escaping (DataResponse<Any>) -> Void) -> (_ data: DataResponse<Any>) -> Void {
    return {
      self.logResponse($0)
      handler($0)
    }
  }
  
  private func logResponse(_ data: DataResponse<Any>) -> Void {
    let log = Report()
    
    log.print("url: \(serverURL)")
    
    let body = data.request
      .flatMap { $0.httpBody }
      .flatMap { String(data: $0, encoding: String.Encoding.utf8) }
      .getOrElse("")
    log.print("body: \(body)")
    
    guard let response = data.response else {
      log.print("no response")
      log.close()
      return
    }

    let statusCode = response.statusCode
    log.print("status code: \(statusCode)")

    let json = JSON(data.result.value.getOrElse(""))
    log.print("response: \(data.result.value.isEmpty() ? "EMPTY" : json)")
    log.close()
  }
  
//  func asd() {
//    let log = Report()
//
//    let baseUrl = self.serverURL + "/"
//    let url = baseUrl + endpoint.specificUrl
//    var headerParams = HTTPHeaders()
//
//    if let endpointHeaderParams = endpoint.headerParams {
//      for key in endpointHeaderParams.keys {
//        headerParams[key] = endpointHeaderParams[key]
//      }
//    }
//
//    log.print("url: \(url) \(endpoint.httpVerb)")
//
//    print("RestServer | hitting: \(endpoint.httpVerb) \(url)")
//    let data = Alamofire.request(url,
//                                 method: endpoint.httpVerb,
//                                 parameters: endpoint.queryParams,
//                                 encoding: JSONEncoding.default,
//                                 headers: headerParams).responseJSON()
//
//
//    let body = data.request
//      .flatMap { $0.httpBody }
//      .flatMap { String(data: $0, encoding: String.Encoding.utf8) }
//      .getOrElse("")
//    log.print("body: \(body)")
//
//    guard let response = data.response else {
//      log.print("no response")
//      log.close()
//      return .failure(data.result.error!)
//    }
//
//    let statusCode = response.statusCode
//    log.print("status code: \(statusCode)")
//
//    let json = JSON(data.result.value.getOrElse(""))
//    log.print("response: \(data.result.value.isEmpty() ? "EMPTY" : json)")
//    log.close()
  
}
